package com.app.metier;

import com.app.model.Article;
import java.util.List;

public interface IGestionArticle {
    void ajouterArticle(Article article);
    List<Article> rechercherArticles(String motCle);
    Article getArticleById(int id);
    void supprimerArticle(int id);
    void modifierArticle(Article article);
}
