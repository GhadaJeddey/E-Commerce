package com.app.controller;

import com.app.dao.ArticleDAO;
import com.app.metier.GestionArticleImpl;
import com.app.metier.IGestionArticle;
import com.app.model.Article;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/article")
public class ArticleServlet extends HttpServlet {

    private IGestionArticle gestionArticle;

    @Override
    public void init() throws ServletException {
        super.init();
        ArticleDAO articleDAO = new ArticleDAO();
        this.gestionArticle = new GestionArticleImpl(articleDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    showDeleteConfirmation(request, response);
                    break;
                case "details":
                    showDetails(request, response);
                    break;
                case "search":  // Nouveau cas
                    searchArticles(request, response);
                    break;

                case "list":
                default:
                    listArticles(request, response);
                    break;
            }
        } catch (Exception e) {
            redirectToError(response, contextPath, "Erreur serveur");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        try {
            switch (action) {
                case "add":
                    addArticle(request, response);
                    break;
                case "update":
                    updateArticle(request, response);
                    break;
                case "delete":
                    deleteArticle(request, response);
                    break;
                default:
                    response.sendRedirect(contextPath + "/article");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace(); // This goes to logs
            request.setAttribute("errorDetails", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void listArticles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Article> articles = gestionArticle.rechercherArticles("");
        request.setAttribute("articles", articles);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/listeArticles.jsp");
        dispatcher.forward(request, response);
    }
    private void addArticle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nom = sanitize(request.getParameter("nom"));
            String description = sanitize(request.getParameter("description"));
            String image = sanitize(request.getParameter("image"));
            double prix = Double.parseDouble(request.getParameter("prix"));

            Article article = new Article(nom, description, prix, image);
            gestionArticle.ajouterArticle(article);
            response.sendRedirect(request.getContextPath() + "/article");
        } catch (NumberFormatException e) {
            redirectToError(response, request.getContextPath(), "Format prix invalide");
        } catch (Exception e) {
            e.printStackTrace(); // This goes to logs
            request.setAttribute("errorDetails", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }



    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/ajouterArticle.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Article article = gestionArticle.getArticleById(id);
            request.setAttribute("article", article);
            request.getRequestDispatcher("/WEB-INF/jsp/modifierArticle.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            redirectToError(response, request.getContextPath(), "ID invalide");
        } catch (RuntimeException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, e.getMessage());
        }
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Article article = gestionArticle.getArticleById(id);
            request.setAttribute("article", article);
            request.getRequestDispatcher("/WEB-INF/jsp/detailsArticle.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            redirectToError(response, request.getContextPath(), "ID invalide");
        } catch (RuntimeException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, e.getMessage());
        }
    }

    private void updateArticle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nom = sanitize(request.getParameter("nom"));
            String description = sanitize(request.getParameter("description"));
            String image = sanitize(request.getParameter("image"));
            double prix = Double.parseDouble(request.getParameter("prix"));

            Article article = new Article(id, nom, description, prix, image);
            gestionArticle.modifierArticle(article);
            response.sendRedirect(request.getContextPath() + "/article");
        } catch (NumberFormatException e) {
            redirectToError(response, request.getContextPath(), "ID ou prix invalide");
        } catch (IllegalArgumentException e) {
            redirectToError(response, request.getContextPath(), e.getMessage());
        } catch (Exception e) {
            e.printStackTrace(); // This goes to logs
            request.setAttribute("errorDetails", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void deleteArticle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            gestionArticle.supprimerArticle(id);
            response.sendRedirect(request.getContextPath() + "/article?action=list&success=Article+supprimé");
        } catch (RuntimeException e) {
            response.sendRedirect(request.getContextPath() + "/article?action=list&error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace(); // This goes to logs
            request.setAttribute("errorDetails", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showDeleteConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Article article = gestionArticle.getArticleById(id);
            request.setAttribute("article", article);
            request.getRequestDispatcher("/WEB-INF/jsp/supprimerArticle.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            redirectToError(response, request.getContextPath(), "ID invalide");
        } catch (RuntimeException e) {
            redirectToError(response, request.getContextPath(), e.getMessage());
        }
    }
    private void searchArticles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Article> articles = gestionArticle.rechercherArticles(keyword);
        request.setAttribute("articles", articles);
        request.getRequestDispatcher("/WEB-INF/jsp/listeArticles.jsp").forward(request, response);
    }

    private String sanitize(String input) {
        return input != null ? input.trim().replaceAll("[<>\"']", "") : "";
    }

    private void redirectToError(HttpServletResponse response, String contextPath, String message)
            throws IOException {
        response.sendRedirect(contextPath + "/error.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }
}
