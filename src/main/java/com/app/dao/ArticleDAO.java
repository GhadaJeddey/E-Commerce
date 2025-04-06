package com.app.dao;

import com.app.model.Article;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


public class ArticleDAO implements IArticleDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/ecommerce";
    private String jdbcUsername = "root";
    private String jdbcPassword = "password";

    protected Connection getConnection() {
        Connection cnx = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // This loads the MySQL JDBC driver (com.mysql.cj.jdbc.Driver) into memory. required for jdbc to comm with mysql
            cnx = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
        catch (SQLException e) {
            System.err.println("MySQL connection failed!");
            e.printStackTrace();
        }
        catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace(); //Prints the error stack trace,
        }
        return cnx;
    }

    public List<Article> getAllArticles() {
        List<Article> articles = new ArrayList<>();
        System.out.println("Début de getAllArticles()");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM articles");
             ResultSet res = ps.executeQuery()) {

            System.out.println("Requête exécutée avec succès");

            while (res.next()) {
                Article article = new Article();
                article.setId(res.getInt("id"));
                article.setNom(res.getString("nom"));
                article.setDescription(res.getString("description"));
                article.setPrix(res.getDouble("prix"));
                article.setImage(res.getString("image"));

                System.out.println("Article chargé : " + article.getNom());
                articles.add(article);
            }

            System.out.println("Nombre total de articles chargés : " + articles.size());

        } catch (SQLException e) {
            System.err.println("ERREUR SQL : " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Échec de la récupération des articles", e);
        }

        return articles;
    }

    public void ajouterArticle(Article article) throws SQLException {
        String sql = "INSERT INTO articles (nom, description, prix, image) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql))
        {
            stmt.setString(1, article.getNom());
            stmt.setString(2, article.getDescription());
            stmt.setDouble(3, article.getPrix());
            stmt.setString(4, article.getImage());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean supprimerArticle(int id) throws SQLException {
        String sql = "DELETE FROM articles WHERE id = ?";
        System.out.println("Attempting to delete product ID: " + id); // Debug log

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();
            System.out.println("Affected rows: " + affectedRows); // Debug log

            // Explicit commit if needed (depends on your DB configuration)
            if (!conn.getAutoCommit()) {
                conn.commit();
            }

            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error deleting product: " + e.getMessage());
            throw e;
        }
    }

    public boolean modifierArticle(Article article) throws SQLException {
        String sql = "UPDATE  articles SET nom = ? , description = ? , prix = ? , image = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql))
        {

            stmt.setString(1, article.getNom());
            stmt.setString(2, article.getDescription());
            stmt.setDouble(3, article.getPrix());
            stmt.setString(4, article.getImage());
            stmt.setInt(5, article.getId());

            int rowsUpdated = stmt.executeUpdate(); // returns 1 si maj reussite

            return rowsUpdated > 0;

        }
    }

    public Article getArticleById(int id) {
        Article article = null;
        String sql = "SELECT * FROM articles WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {
                    article = new Article();
                    article.setId(rs.getInt("id"));
                    article.setNom(rs.getString("nom"));
                    article.setDescription(rs.getString("description"));
                    article.setPrix(rs.getDouble("prix"));
                    article.setImage(rs.getString("image"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du article:");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Erreur générale:");
            e.printStackTrace();
        }
        return article;
    }



    public Optional<Article> findById(int id) {
        Article p = getArticleById(id);
        return p != null ? Optional.of(p) : Optional.empty();
    }

    public List<Article> search(String keyword) throws SQLException {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT * FROM articles WHERE LOWER(nom) LIKE ? OR LOWER(description) LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Ajout des paramètres de recherche (avec % pour la recherche partielle)
            String searchPattern = "%" + keyword.toLowerCase() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Article article = new Article();
                    article.setId(rs.getInt("id"));
                    article.setNom(rs.getString("nom"));
                    article.setDescription(rs.getString("description"));
                    article.setPrix(rs.getDouble("prix"));
                    article.setImage(rs.getString("image"));
                    articles.add(article);
                }
            }
        }
        return articles;
    }

}





