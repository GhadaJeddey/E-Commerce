package com.app.controller;

import com.app.dao.UserDAO;
import com.app.metier.GestionUserImpl;
import com.app.metier.IGestionUser;
import com.app.model.User;
import com.app.security.PasswordHasher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/loginAction")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IGestionUser gestionUser;

    @Override
    public void init() throws ServletException {
        super.init();
        UserDAO userDAO = new UserDAO();
        this.gestionUser = new GestionUserImpl(userDAO);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("loginservlt   "+ password);

        try {

            User user = gestionUser.authenticateUser(email, password);

            if (user != null) {

                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }


                HttpSession newSession = request.getSession(true);
                newSession.setMaxInactiveInterval(30 * 60); // 30 minutes
                newSession.setAttribute("currentUser", user);
                newSession.setAttribute("freshLogin", true);

                response.sendRedirect(request.getContextPath() + "/article");
            } else {
                request.setAttribute("errorMessage", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, "Erreur d'authentification", e);
            request.setAttribute("errorMessage", "Erreur technique");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}