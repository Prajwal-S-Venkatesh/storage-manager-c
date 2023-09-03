# Assignment 1 - Storage Manager

Course: CS525 Advance Database Organization - 2023 Summer

## Group Members

```
Name: Prajwal Somendyapanahalli Venkateshmurthy
CWID: A20524002
Hawk Email: psomendyapanahallive@hawk.iit.edu

Name: Komal Bhavake
CWID: A20520501
Hawk Email: kbhavake@hawk.iit.edu

Name: Ravin N Krishnan
CWID: A20529195
Hawk Email: rnavaneethankrishnan@hawk.iit.edu
```

## How to run the code

```bash
make && make run_test && make clean
```

## Solution Approach

### Interfaces for manipulating page in files

-  **initStorageManager():** 
    - Initialize the globally defined fileHandle attributes to default values

-  **createPageFile():**
    - Create a file pointer and open the file in write in binary mode
    - If the file is non existent, return `RC_FILE_NOT_FOUND`
    - Create a new page of size PAGE_SIZE
    - If the page is not created, return `RC_WRITE_FAILED`
    - Fill the page with 0's as it is a new page
    - If the write is not successful, return `RC_WRITE_FAILED`
    - Close the file and free the page to avoid memory leaks
    - Return `RC_OK` if the file is created successfully

-  **openPageFile():**
    - Open the file in read and write(+) in binary mode
    - If the file is non existent, return `RC_FILE_NOT_FOUND`
    - Assign the fileHandle attributes to the values of the file, totalNumPages = FILE_SIZE / PAGE_SIZE
    - Close the file to avoid memory leaks
    - Return `RC_OK` if the file is opened successfully

-  **closePageFile():**
    - If the fileHandle or its fileName is not initialized, return `RC_FILE_HANDLE_NOT_INIT`
    - Clear the file handle's members
    - If the fileHandle is initialized, free the fileName to avoid memory leaks
    - Return `RC_OK` if the file is closed successfully

-  **destroyPageFile():**
    - Remove the file from the disk
    - If the file is non existent, return `RC_FILE_NOT_FOUND`
    - Return `RC_OK` if the file is destroyed successfully

### Interfaces for reading blocks from disc

-  **readBlock():**
    - Open the file in `r+` mode
    - Seek till the starting of the page
    - If seek failed return `RC_FILE_SEEK_FAILED`
    - Read the page contents to memPage with byte size as 1 till `PAGE_SIZE` bytes
    - Update current page position using `ftell`
    - Close the file
    - Return `RC_OK`

-  **getBlockPos():**
    - Return current page position

-  **readFirstBlock():**
    - Call `readBlock` on the first page

-  **readPreviousBlock():**
    - Call `readBlock` on the previous page

-  **readCurrentBlock():**
    - Call `readBlock` on current page

-  **readNextBlock():**
    - Call `readBlock` on next page

-  **readLastBlock():**
    - Call `readBlock` on last page - `totalNumPages - 1`

### Interfaces for writing blocks to disc

-  **writeBlock():**
    - OPEN FILE IN MODE THAT CAN BE BOTH WRITTEN AND READ                                                                      
    - CHECK IF FILE IS NULL
    - RETURN `RC_FILE_NOT_FOUND` IF FILE IS NULL     
    - CHECK IF FHANDLE IS NOT INITIALIZED OR NOT
    - RETURN `RC_FILE_HANDLE_NOT_INIT` IF IT IS NOT INITIALIZED
    - CHECK FOR ERRORS THAT MAY CAUSE FAILURE  
    - RETURN `RC_WRITE_FAILED` IF THESE ERRORS EXIST   
    - MOVE TO GIVEN POSITION WHERE WRITE SHOULD BE PERFORMED
    - WRITE THE PAGE TO THE DISK 
    - RETURN `RC_OK` AFTER SUCCESSFUL METHOD CALL 
    - IF FSEEK HAS FAILED RETURN `RC_WRITE_FAILED`  
    - CLOSE THE FILE
    
-  **writeCurrentBlock():**
    - CREATE VARIABLES TO STORE THE RETURN CODE AND CURRENT POSITION
    - CHECK IF FILE HANDLE IS INITIALISED
    - IF NOT,RETURN `RC_FILE_HANDLE_NOT_INIT`
    - IF YES,GET THE CURRENT POSITION USING GETBLOCKPOS()
    - PERFORM WRITEBLOCK() USING CURRENT POSITION AND STORE THE RETURN CODE 
    - RETURN THE RETURNCODE WHICH IS EITHER `RC_OK` IF SUCCESSFULL OR `RC_WRITE_FAILED` IF UNSUCCESSFUL
    
-  **appendEmptyBlock():**
    - CHECK IF FILE HANDLE IS INITIALISED
    - IF NOT,RETURN `RC_FILE_HANDLE_NOT_INIT`
    - OTHERWISE,OPEN FILE IN READ AND WRITE MODE
    - MOVE TO END OF THE FILE
    - CREATE A WHILE LOOP THAT ITERATES "PAGE_SIZE" TIMES
    - PRINT '\0' IN EACH ITERATION OF THE LOOP
    - CLOSE THE FILE
    - RETURN `RC_OK` IF THE BLOCK IS APPENDED SUCCESSFULLY
    
-  **ensureCapacity():**
    - CHECK IF FILE HANDLE IS INITIALISED
    - IF NOT,RETURN `RC_FILE_HANDLE_NOT_INIT`
    - IF YES,CHECK IF THERE IS A DIFFERENCE IN NUMBER OF PAGES AND TOTAL NUMBER OF PAGES
    - IF A DIFFERENCE EXISTS,USE A WHILE LOOP TO APPEND PAGES UNTIL THE DIFFERENCE IS NULLIFIED
    - RETURN `RC_OK` AFTER SUCCESSFUL OPERATION


