package com.app.dao;
import com.app.model.User;

import java.sql.SQLException;

public interface IUserDAO  {
    void insertUser(User user) throws SQLException;
    User findUserByEmail(String email);
}
