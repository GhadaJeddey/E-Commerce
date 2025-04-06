package com.app.dao;

import com.app.model.Article;
import java.sql.*;
import java.util.List;

public interface IArticleDAO {
    List<Article> getAllArticles();
    void ajouterArticle(Article article) throws SQLException;
    boolean supprimerArticle(int id) throws SQLException;
    boolean modifierArticle(Article article) throws SQLException;
    Article getArticleById(int id);
    List<Article> search(String keyword) throws SQLException;

}
