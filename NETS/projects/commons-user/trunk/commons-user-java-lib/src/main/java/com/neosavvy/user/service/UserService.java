package com.neosavvy.user.service;

import com.neosavvy.user.dto.UserDTO;
import org.springframework.security.annotation.Secured;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.jws.WebService;
import javax.jws.WebMethod;

import java.util.List;

@Path("/helloWorldService/")
public interface UserService {

    @Secured("ROLE_ADMIN")
	public List<UserDTO> getUsers();

	public void saveUser(UserDTO user);

    @Secured("ROLE_ADMIN")
	public UserDTO findUserById(int id);

    @Secured("ROLE_ADMIN")
	public List<UserDTO> findUsers(UserDTO user);

    @Secured("ROLE_ADMIN")
	public void deleteUser(UserDTO user);

    public Boolean login(UserDTO user);

    public Boolean logout(UserDTO user);

    @GET
	@Path("/")
    public String test();
    
}
