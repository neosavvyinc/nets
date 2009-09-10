package com.neosavvy.skeleton.service;

import com.neosavvy.skeleton.dto.MessageDTO;

public class SkeletonServiceImpl implements SkeletonService {

	public MessageDTO[] getMessages() {
		MessageDTO message = new MessageDTO();
		message.setId(10);
		message.setMessageString("Hello, World");
		
		return new MessageDTO[]{message};
	}

}
