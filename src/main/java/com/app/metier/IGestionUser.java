package com.app.metier;

import com.app.model.User;

public interface IGestionUser {
    void registerUser(User user) throws Exception;
    User authenticateUser(String email, String password);
}
