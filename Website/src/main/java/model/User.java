package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class User {
	String firstName, lastName, username, password, role, profilePicture, email, phoneNumber;
	public User() {}
	
	public User(String firstName, String lastName, String username, 
			String password, String email, String phoneNumber, Part part){
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.profilePicture = getImageUrl(part);
	}
	
	public String getProfilePicture() {
		return profilePicture;
	}
	
	public void setProfilePicture(Part part) {
		this.profilePicture = getImageUrl(part);
	}
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getUsername() {
		return username	;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	private String getImageUrl(Part part) {
		String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
		File fileSaveDir = new File(savePath);
		String profilePicture = null;
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				profilePicture = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		if(profilePicture == null || profilePicture.isEmpty()) {
			profilePicture = "download.png";
		}
		return profilePicture;
	}
}
