package com.app.metier;

import com.app.dao.ArticleDAO;
import com.app.model.Article;

import java.sql.SQLException;
import java.util.List;

public class GestionArticleImpl implements IGestionArticle {
    private final ArticleDAO articleDAO;

    public GestionArticleImpl(ArticleDAO articleDAO) {
        this.articleDAO = articleDAO;
    }

    @Override
    public void ajouterArticle(Article article) {
        if (article.getPrix() <= 0) {
            throw new IllegalArgumentException("Le prix doit être positif");
        }
        try {
            articleDAO.ajouterArticle(article);
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de l'ajout du article", e);
        }
    }

    @Override
    public List<Article> rechercherArticles(String motCle) {
        try {
            if (motCle == null || motCle.trim().isEmpty()) {
                return articleDAO.getAllArticles();
            }
            return articleDAO.search(motCle);
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche: " + e.getMessage());
            throw new RuntimeException("Erreur lors de la recherche d'articles", e);
        }
    }

    @Override
    public Article getArticleById(int id) {
        return articleDAO.findById(id)
                .orElseThrow(() -> new RuntimeException("Article non trouvé"));
    }

    @Override
    public void supprimerArticle(int id) {
        try {
            boolean deleted = articleDAO.supprimerArticle(id);
            if (!deleted) {

                System.out.println("Article non trouvé ou échec de suppression");
            } else {
                System.out.println("Article supprimé avec succès");
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    @Override
    public void modifierArticle(Article article) {
        try {
            boolean updated = articleDAO.modifierArticle(article);
            if (!updated) {

                System.out.println("Échec de la mise à jour du article");
            } else {
                System.out.println("Article mis à jour avec succès");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
