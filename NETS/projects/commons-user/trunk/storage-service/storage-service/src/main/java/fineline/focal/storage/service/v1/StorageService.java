package fineline.focal.storage.service.v1;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.Encoded;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import fineline.focal.common.types.v1.StorageServiceFileRef;

@Path("/")
public interface StorageService
{
    @GET
    @Path(value="/file/{bucket:.*?}/{key:.*}") 
    @Encoded
    public Response downloadFile(@PathParam("bucket")String bucket, @PathParam("key")String key) throws Exception;
    
    @POST
    @Path(value="/file/{bucket:.*?}/{key:.*}")
    @Encoded
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces({MediaType.TEXT_XML})
    public StorageServiceFileRef uploadFile(@PathParam("bucket")String bucket, @PathParam("key")String key) throws Exception;

    @DELETE
    @Path(value="/file/{bucket:.*?}/{key:.*}")
    @Encoded
    public String deleteFile(@PathParam("bucket")String bucket, @PathParam("key")String key) throws Exception;

    @GET
    @Path(value="/fileRef/{bucket:.*?}/{key:.*}") 
    @Encoded
    @Produces(MediaType.TEXT_XML)
    public StorageServiceFileRef findFileRef(@PathParam("bucket")String bucket, @PathParam("key")String key) throws Exception;
    
}
