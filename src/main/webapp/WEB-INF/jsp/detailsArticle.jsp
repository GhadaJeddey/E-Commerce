<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de l'article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .product-detail-card {
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        .product-image {
            height: 300px;
            object-fit: contain;
            background: #f8f9fa;
            border-radius: 10px 10px 0 0;
        }
        .back-btn {
            transition: all 0.3s;
        }
        .back-btn:hover {
            transform: translateX(-3px);
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card product-detail-card mb-4">
                <c:if test="${not empty article.image}">
                    <img src="${article.image}" class="card-img-top product-image" alt="${article.nom}">
                </c:if>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h1 class="card-title text-primary">${article.nom}</h1>
                            <p class="text-muted">Référence: #${article.id}</p>
                        </div>
                        <h3 class="text-success">${article.prix} TND</h3>
                    </div>

                    <hr>

                    <h5 class="mt-4"><i class="bi bi-card-text"></i> Description</h5>
                    <p class="card-text lead">${article.description}</p>

                    <div class="d-flex justify-content-between mt-5">
                        <a href="article" class="btn btn-outline-primary back-btn">
                            <i class="bi bi-arrow-left"></i> Retour à la liste
                        </a>
                        <div>
                            <a href="article?action=edit&id=${article.id}" class="btn btn-warning">
                                <i class="bi bi-pencil"></i> Modifier
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>