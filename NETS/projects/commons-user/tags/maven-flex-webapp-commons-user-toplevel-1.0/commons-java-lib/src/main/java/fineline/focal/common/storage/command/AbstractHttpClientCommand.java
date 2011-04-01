package fineline.focal.common.storage.command;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URIException;
import org.apache.commons.httpclient.util.URIUtil;

import fineline.focal.common.storage.StorageException;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
public abstract class AbstractHttpClientCommand
{
    protected HttpClient client;
    protected HttpMethod method;
    protected String url;
    
    public AbstractHttpClientCommand(String url) {
        client = new HttpClient();
        this.url = url;
    }
    
    public void execute() throws StorageException {
        try {
            method = createMethod();
            method.addRequestHeader("Accept", "application/xml, text/html, */*");
            int statusCode = client.executeMethod(method);

            if (statusCode != HttpStatus.SC_OK) {
                onError(statusCode);
            }
            else {
                onOk();
            }
        }
        catch (HttpException e) {
            throw new StorageException(e.getMessage(), e);
        }
        catch (IOException e) {
            throw new StorageException(e.getMessage(), e);
        }
        finally {
            if (method != null) {
                method.releaseConnection();
            }
        }
    }

    protected String buildUrl(String base, String...pathParams) throws StorageException {
        StringBuilder fullUrl = new StringBuilder(base);
        
        try {
            for (String param : pathParams) {
                fullUrl.append("/");
                fullUrl.append(URIUtil.encodePath(param));
            }
        }
        catch (URIException e) {
            throw new StorageException(e.getMessage(), e);
        }
        
        return fullUrl.toString();
    }
    
    protected abstract HttpMethod createMethod() throws StorageException;
    protected abstract void onError(int statusCode) throws StorageException;
    protected abstract void onOk() throws StorageException;
}
