package com.app.controller;

import com.app.metier.GestionUserImpl;
import com.app.metier.IGestionUser;
import com.app.dao.UserDAO;
import com.app.model.User;
import com.app.security.PasswordHasher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    private IGestionUser gestionUser;

    @Override
    public void init() throws ServletException {
        super.init();
        UserDAO userDAO = new UserDAO();
        this.gestionUser = new GestionUserImpl(userDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim().toLowerCase();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");


        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            User user = new User();
            user.setEmail(email);
            user.setUsername(username);
            user.setPassword(password);

            gestionUser.registerUser(user);

            request.getSession().setAttribute("successMessage", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}