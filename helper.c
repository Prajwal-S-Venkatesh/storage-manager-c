
extern void resetHandle(SM_FileHandle *fileHandle)
{
    if (fileHandle == NULL)
    {
        return;
    }
    free(fileHandle);
}