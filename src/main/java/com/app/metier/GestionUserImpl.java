package com.app.metier;
import com.app.model.User;
import com.app.dao.IUserDAO;
import com.app.security.PasswordHasher;

public class GestionUserImpl implements IGestionUser {
    private IUserDAO userDAO;

    public GestionUserImpl(IUserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    public void registerUser(User user) throws Exception {
        String hashedPassword = PasswordHasher.hash(user.getPassword());

        user.setPassword(hashedPassword);
        userDAO.insertUser(user);
    }
    @Override
    public User authenticateUser(String email, String password) {

        User user = userDAO.findUserByEmail(email);
        System.out.println(PasswordHasher.verify(password, user.getPassword()));
        System.out.println(user.getPassword());
        System.out.println(password);
        System.out.println(PasswordHasher.hash(password));

        if (user != null && PasswordHasher.verify(password, user.getPassword())) {
            return user;
        }
        return null;
    }

}
