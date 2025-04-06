<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation de suppression</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .confirmation-card {
            max-width: 600px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            border: none;
        }
        .warning-header {
            background: linear-gradient(135deg, #ffc107 0%, #f44336 100%);
            border-radius: 15px 15px 0 0 !important;
        }
        .product-preview {
            height: 150px;
            object-fit: contain;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 10px;
        }
        .btn-cancel {
            transition: all 0.3s;
        }
        .btn-cancel:hover {
            transform: translateX(-3px);
        }
        .btn-delete {
            transition: all 0.3s;
        }
        .btn-delete:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card confirmation-card">
                <div class="card-header text-white warning-header">
                    <h2 class="mb-0"><i class="bi bi-exclamation-triangle-fill"></i> Confirmation requise</h2>
                </div>
                <div class="card-body text-center">
                    <div class="alert alert-danger" role="alert">
                        <h4 class="alert-heading">Attention !</h4>
                        <p>Vous êtes sur le point de supprimer définitivement ce article.</p>
                        <hr>
                        <p class="mb-0">Cette action est irréversible.</p>
                    </div>

                    <div class="d-flex justify-content-center mb-4">
                        <c:choose>
                            <c:when test="${not empty article.image}">
                                <img src="${article.image}" class="product-preview me-4" alt="${article.nom}">
                            </c:when>
                            <c:otherwise>
                                <div class="product-preview d-flex align-items-center justify-content-center text-muted me-4">
                                    <i class="bi bi-image" style="font-size: 2rem;"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="text-start">
                            <h4>${article.nom}</h4>
                            <p class="text-muted">Référence: #${article.id}</p>
                            <p class="lead">${article.prix} TND</p>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/article" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${article.id}">

                        <div class="d-flex justify-content-center">
                            <a href="article?action=details&id=${article.id}" class="btn btn-lg btn-outline-secondary btn-cancel me-3">
                                <i class="bi bi-arrow-left-circle"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-lg btn-danger btn-delete">
                                <i class="bi bi-trash-fill"></i> Confirmer la suppression
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>