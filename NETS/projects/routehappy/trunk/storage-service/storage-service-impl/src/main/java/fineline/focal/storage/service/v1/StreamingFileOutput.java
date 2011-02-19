package fineline.focal.storage.service.v1;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.StreamingOutput;

public class StreamingFileOutput implements StreamingOutput
{
    private File inputFile;
    private StreamCompleteListener streamCompleteListener;

    public StreamingFileOutput() {
    
    }
    
    public StreamingFileOutput(File inputFile) {
        this.inputFile = inputFile;
    }
    
    public File getInputFile() {
        return inputFile;
    }

    public void setInputFile(File inputFile) {
        this.inputFile = inputFile;
    }

    public void write(OutputStream outputStream) throws IOException, WebApplicationException {
        InputStream is = new BufferedInputStream(new FileInputStream(inputFile));
        
        try {
            byte[] buffer = new byte[32768];
            int size = 0;
            while ((size = is.read(buffer)) != -1) {
                outputStream.write(buffer, 0, size);
            }
            is.close();
            
            if (streamCompleteListener != null) {
                streamCompleteListener.onStreamComplete();
            }
        }
        finally {
            is.close();
        }
    }

    public StreamCompleteListener getStreamCompleteListener() {
        return streamCompleteListener;
    }

    public void setStreamCompleteListener(StreamCompleteListener streamCompleteListener) {
        this.streamCompleteListener = streamCompleteListener;
    }   
}