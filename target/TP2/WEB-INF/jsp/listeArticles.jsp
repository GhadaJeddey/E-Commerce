<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .product-card {
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .search-box {
            max-width: 400px;
        }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-box-seam"></i> Gestion des Articles
        </a>
        <div class="d-flex">
            <span class="navbar-text text-white me-3">
                <c:if test="${not empty sessionScope.currentUser}">
                    <i class="bi bi-person-circle"></i> ${sessionScope.currentUser.username}
                </c:if>
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                <i class="bi bi-box-arrow-left"></i> Déconnexion
            </a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <!-- En-tête avec lien Accueil -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="text-primary">
            <i class="bi bi-list-task"></i> Articles
        </h1>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary">
            <i class="bi bi-house-door"></i> Accueil
        </a>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-column flex-md-row gap-3">
        <form class="d-flex flex-grow-1 me-md-3 search-box"
              action="${pageContext.request.contextPath}/article"
              method="get">
            <input type="hidden" name="action" value="search">
            <div class="input-group shadow-sm">
                <input type="text"
                       class="form-control"
                       name="keyword"
                       value="${param.keyword}"
                       placeholder="Rechercher un article..."
                       aria-label="Rechercher un article">
                <button class="btn btn-primary" type="submit" aria-label="Lancer la recherche">
                    <i class="bi bi-search"></i> Rechercher
                </button>
                <c:if test="${not empty param.keyword}">
                    <a href="${pageContext.request.contextPath}/article"
                       class="btn btn-outline-secondary"
                       aria-label="Réinitialiser la recherche">
                        <i class="bi bi-x-lg"></i>
                    </a>
                </c:if>
            </div>
        </form>

        <a href="${pageContext.request.contextPath}/article?action=new"
           class="btn btn-success flex-shrink-0">
            <i class="bi bi-plus-lg"></i> Nouvel Article
        </a>
    </div>

    <!-- Messages d'alerte -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show mb-4">
                ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show mb-4">
                ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Liste des articles -->
    <c:choose>
        <c:when test="${not empty articles}">
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach items="${articles}" var="article">
                    <div class="col">
                        <div class="card h-100 product-card">
                            <c:if test="${not empty article.image}">
                                <img src="${article.image}"
                                     class="card-img-top"
                                     alt="${article.nom}"
                                     style="height: 200px; object-fit: cover;">
                            </c:if>
                            <div class="card-body">
                                <h5 class="card-title">${article.nom}</h5>
                                <p class="card-text text-muted">${article.description}</p>
                                <p class="h4 text-success">${article.prix} TND</p>
                            </div>
                            <div class="card-footer bg-white">
                                <div class="d-flex justify-content-between">
                                    <a href="article?action=details&id=${article.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-eye"></i> Détails
                                    </a>
                                    <a href="article?action=edit&id=${article.id}"
                                       class="btn btn-sm btn-outline-warning">
                                        <i class="bi bi-pencil"></i> Modifier
                                    </a>
                                    <a href="article?action=delete&id=${article.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet article ?')">
                                        <i class="bi bi-trash"></i> Supprimer
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i>
                <c:choose>
                    <c:when test="${not empty param.keyword}">
                        Aucun résultat pour "${param.keyword}"
                    </c:when>
                    <c:otherwise>
                        Aucun article disponible
                    </c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>