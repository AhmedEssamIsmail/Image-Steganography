INCLUDE Macros.inc
INCLUDE Irvine32.inc
;Constants 
	FilePathLength = 200
	MaxMsgSize = 1001
	MaxImageSize = 100000
.data
	BytesWrittenOrRead Dword ?
	XorKey Dword ?
	FilePath Byte FilePathLength dup (?) , 0
	Msg Byte MaxMsgSize dup(?) , 0
	MsgSize Dword 0
	ImageArray Byte MaxImageSize dup(?) , 0
	FileHandle Handle ?
.code
main PROC
;Intro
	mWrite <"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",0dh,0ah>
	mWrite <"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",0dh,0ah>
	mWrite <"- - - - - - - - - - - - - I M A G E - S T E G A N O G R R A P H Y - - - - - - - - - - - -",0dh,0ah>
	mWrite <"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",0dh,0ah>
	mWrite <"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",0dh,0ah>
	call crlf
	mWrite <"Select Operation: ",0dh,0ah>
	mWrite <"+ Encrypt (e)",0dh,0ah>
	mWrite <"+ Decrypt (d)",0dh,0ah>
	mWrite <"+ Exit (Any Other Character)",0dh,0ah>
;Get Choice
	call readchar
	cmp al , 'e'
	JE ChoseEncrypt
	cmp al , 'd'
	JE ChoseDecrypt
	jmp Quit
ChoseEncrypt:
	call ClearScreen
	call Encrypt
	jmp Quit
ChoseDecrypt:
	call ClearScreen
	call Decrypt
Quit:
call crlf

exit
main ENDP
;-------------------------------------------------------------------------------
Encrypt PROC
;Takes the FilePath, Message and XOR key from the user
;then calls the procedures responsible for every operation
;Receives: Nothing
;Returns: Nothing
;-------------------------------------------------------------------------------

;Getting filepath, message and encryption key from the user
	mWrite <"Enter the file path (Including The File Name) to the text file containing the ",0dh,0ah>
	mWrite <"RGB pixels of the Image",0dh,0ah,0ah>
    mReadString FilePath
	call OpenFile
	mov edx , OFFSET ImageArray
	mov ecx , MaxImageSize
	call ReadInputFile
	mov BytesWrittenOrRead , eax
	mov eax , FileHandle
	call CloseFile
	mWrite <0dh,0ah,"Enter the message you would like to encrypt (Max: 1000 Characters)",0dh,0ah>
	mReadString Msg
	mov MsgSize , eax
	mWrite <0dh,0ah,"Enter the key that will be used to encrypt the message",0dh,0ah>
	call readdec
;XORing the message and adding ';' as a message terminator to indicate the end of message in the ImageArray
	mov XorKey , eax
	mov edx , OFFSET Msg
	call XorMsg
	mov edx , OFFSET Msg
	add edx , MsgSize
	mov byte ptr[edx] , ';'
	inc MsgSize
	call EncryptAux
	call ClearScreen
	mWrite <"MESSAGE ENCRYPTED.",0dh,0ah,0dh,0ah,"Encryption key: ">
	mov eax , XorKey
	call writedec
	call crlf
	mWrite <"File Path: ">
	mov edx , offset FilePath
	call writestring
	call crlf
ret
Encrypt ENDP
;-------------------------------------------------------------------------------
EncryptAux PROC
;
;Starts iterating over the channels of each pixel and the characters
;of the message to be hidden, changing the LSB of each channel 
;according to the characters of the message
;Receives: Nothing
;Returns: Nothing
;-------------------------------------------------------------------------------

	mov esi , OFFSET ImageArray
	mov edx , OFFSET Msg
	mov ecx , MsgSize
;Skipping width and height written in the file
	call GetNextNum 
	call GetNextNum
HideMsg:
	PUSH ecx
	mov ecx , 8
	mov bl , [edx]
	HideChar:
		call GetNextNum
		mov edi , esi
		sub edi , 2
		SHR bl , 1
		JC PutOne
		AND al , 11111110b
		JMP Finished
	PutOne:
		OR al , 00000001b
	Finished:
		mov [edi] , al
	LOOP HideChar
	inc edx
	POP ecx
LOOP HideMsg
;Re-opens the file to re-write the bytes into the file after the changes
	mov edx , OFFSET FilePath
	call OpenFile
	mov edx , OFFSET ImageArray
	mov ecx , BytesWrittenOrRead
	call WriteInFile
	mov eax , FileHandle
	call CloseFile
ret
EncryptAux ENDP
;-------------------------------------------------------------------------------
GetNextNum PROC 
;
;Searchs the Image Array for the next '\r' which indicates the end 
;of a channel then returns the the last digit of the channel that
;needs to be changed
;Receives: ESI pointing the end of the last channel
;Returns: AL containing the last digit of the next channel, ESI 
;pointing to the '\n' that follows each '\r' for the next search to start at
;-------------------------------------------------------------------------------
	mov eax , 0
Continue:
	mov al , [esi]
	cmp al , 13
	JE Done
	inc esi
	JMP Continue
Done:
	mov al , [esi - 1]
	inc esi
ret
GetNextNum ENDP
;-------------------------------------------------------------------------------
XorMsg PROC
;
;XORs the message according the XorKey's value mod(%) 255 
;to be a max of 8 bits so that it's the same size as each character
;Receives: EDX pointing to the message start
;Returns: Nothing
;-------------------------------------------------------------------------------
	PUSH edx
	mov edx , 0 
	mov ebx , 255
	mov eax , Xorkey
	div ebx
	mov bl , dl
	POP edx
	mov ecx , MsgSize
LoopOnMsg:
	mov al , [edx]
	xor al , bl
	mov [edx] , al
	inc edx
LOOP LoopOnMsg
ret
XorMsg ENDP
;-------------------------------------------------------------------------------
Decrypt PROC
;
;Decrypts the Message Hidden inside the RGB pixels of an Image 
;Receives: Nothing
;Returns: Outputs the Decrypted message from the ImageArray
;     	  to the screen
;-------------------------------------------------------------------------------

;Getting filepath and encryption key from the user
	mWrite <"Enter the file path (Including The File Name) to the text file containing the ",0dh,0ah>
	mWrite <"RGB pixels of the Image",0dh,0ah,0ah>
    mReadString FilePath
	call OpenFile
	mov edx , OFFSET ImageArray
	mov ecx , MaxImageSize
	call ReadInputFile
	mov BytesWrittenOrRead , eax
	mov eax , FileHandle
	call CloseFile
	mWrite <0dh,0ah,"Enter the key that was used to encrypt the message",0dh,0ah>
	call readdec
	cmp eax , 0
	JNE Continue
	inc eax
Continue:
	mov XorKey , eax
	mov edx , OFFSET Msg
	call DecryptAux
	mov edx , OFFSET Msg
	call XorMsg
	call ClearScreen
	mWrite <"MESSAGE DECRYPTED.",0dh,0ah,0dh,0ah,"Decryption key used is: ">
	mov eax , XorKey
	call writedec
	call crlf
	mWrite <"File Path used is: ">
	mov edx , offset FilePath
	call writestring
	mWrite <0dh,0ah,0dh,0ah,"Message:",0dh,0ah>
	mov edx , OFFSET Msg
	call writestring
	call crlf
ret
Decrypt ENDP
;------------------------------------------------------------------
DecryptAux PROC
;
;Extracts the LSB of each channel in the Image Array then uses each 8 bits 
;to form a character in the message, continues to do so until it finds a ';'
;which indicates the end of the message in the Image Array
;Receives: Nothing
;Returns: Nothing
;------------------------------------------------------------------
	mov esi , OFFSET ImageArray
	mov edx , OFFSET Msg
;Skipping width and height of the image array
	call GetNextNum
	call GetNextNum
RetrieveMsg:
	mov ecx , 8
	mov bl , 0
	RetrieveChar:
		call GetNextNum
		and al , 00000001b
		cmp al , 1
		JE PutOne
		CLC 
		RCR bl , 1
		JMP Finished
	PutOne:
		STC
		RCR bl , 1
	Finished:
	LOOP RetrieveChar
	cmp bl , 59
	JE Done
	mov byte ptr[edx] , bl
	inc edx
	inc MsgSize
	JMP RetrieveMsg
Done:
	inc edx
	mov byte ptr[edx] , 0
ret
DecryptAux ENDP
;------------------------------------------------------------------
OpenFile PROC
;
;Tries to open the file from the given FilePath if the path doesn't
;point to a valid file the function re-call itself until a valid path
;is provided of the users Breaks from the Program.
;Recevies: Nothing
;Returns: file handle in the variable FileHandle
;------------------------------------------------------------------
	mov edx , OFFSET FilePath
	call OpenFileRW 
	cmp eax , INVALID_HANDLE_VALUE
	JNE Found
	call ClearScreen
	mWrite <0dh,0ah,"File Not Found... ",0dh,0ah>
	mWrite <"Enter File Path again or break (Ctrl+C) to Exit",0dh,0ah,0dh,0ah>
	mReadString FilePath
	call OpenFile
Found:
	mov FileHandle , eax
ret
OpenFile ENDP
;------------------------------------------------------------------
CreateNewFile PROC
;
;Creates and Opens file if it doesn't exist in READ/WRITE mode.
;Receives:  EDX pointer to the FilePath
;Returns:   EAX as file handle
;------------------------------------------------------------------
	INVOKE CreateFile , edx , GENERIC_ALL , FILE_SHARE_READ ,NULL , CREATE_ALWAYS , FILE_ATTRIBUTE_NORMAL , 0
ret
CreateNewFile ENDP
;------------------------------------------------------------------
OpenFileRW PROC
;
;Opens file if it exist in READ/WRITE mode.
;Receives:  EDX pointer to the FilePath
;Returns:   EAX as file handle ,
;		    or INVALID_HANDLE_VALUE if the file doesn't exit 
;------------------------------------------------------------------
	INVOKE CreateFile , edx , GENERIC_ALL , FILE_SHARE_READ ,NULL , OPEN_EXISTING , FILE_ATTRIBUTE_NORMAL , 0
ret
OpenFileRW ENDP
;------------------------------------------------------------------
WriteInFile PROC
;
;Opens file if it exist in READ/WRITE mode.
;Receives:  EAX as file handle, EDX as pointer to array to write
;			ECX as number of bytes to write  
;Returns:   EAX Number of bytes written
;------------------------------------------------------------------
	INVOKE WriteFile , eax  , edx , ecx , ADDR BytesWrittenOrRead , 0
	mov eax , BytesWrittenOrRead
ret
WriteInFile ENDP
;------------------------------------------------------------------
ReadInputFile PROC
;
;Opens file if it exist in READ/WRITE mode.
;Receives:  EAX as file handle, EDX as pointer to array to read into
;			ECX as number of bytes to read  
;Returns:   EAX Number of bytes read
;------------------------------------------------------------------
	INVOKE ReadFile , eax  , edx , ecx , ADDR BytesWrittenOrRead , 0
	mov eax , BytesWrittenOrRead
ret
ReadInputFile ENDP
;------------------------------------------------------------------
ClearScreen PROC
;
;Clears the Screen and resets the cursor
;Recieves: Nothing
;Returns: Nothing
;------------------------------------------------------------------
	mGoToXY 0 , 0
	mWriteSpace 1500
	mGoToXY 0 , 0
ret
ClearScreen ENDP

END main