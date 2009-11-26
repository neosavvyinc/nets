package com.neosavvy.user.rest;

import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Controller
@Path(UserResource.USER_RESOURCE_URL)
public class UserResource {

    public static final String USER_RESOURCE_URL = "/users";

    @Autowired
    public UserService userService;

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @GET
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    @Path("data")
    public List<UserDTO> getUsers() {
        return userService.getUsers();
    }



}
