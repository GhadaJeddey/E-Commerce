<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .edit-form-container {
            max-width: 800px;
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        .form-header {
            border-radius: 15px 15px 0 0 !important;
        }
        .product-preview {
            height: 200px;
            object-fit: contain;
            background: #f8f9fa;
            border: 1px dashed #dee2e6;
            border-radius: 8px;
        }
        .image-upload-wrapper {
            transition: all 0.3s;
        }
        .image-upload-wrapper:hover {
            transform: scale(1.02);
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card edit-form-container">
                <div class="card-header bg-warning text-white form-header">
                    <h2 class="mb-0"><i class="bi bi-pencil-square"></i> Modifier Article #${article.id}</h2>
                </div>
                <div class="card-body">
                    <form action="article" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${article.id}">

                        <!-- Preview Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="image-upload-wrapper text-center mb-3">
                                    <c:choose>
                                        <c:when test="${not empty article.image}">
                                            <img id="imagePreview" src="${article.image}" class="product-preview w-100 mb-2">
                                        </c:when>
                                        <c:otherwise>
                                            <div id="imagePreview" class="product-preview d-flex align-items-center justify-content-center text-muted">
                                                <i class="bi bi-image" style="font-size: 3rem;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-md-6 d-flex align-items-center">
                                <div>
                                    <h4>${article.nom}</h4>
                                    <p class="text-muted">Référence: #${article.id}</p>
                                    <h5 class="text-success">${article.prix} TND</h5>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <!-- Form Fields -->
                        <div class="mb-3">
                            <label for="nom" class="form-label">Nom du article</label>
                            <input type="text" class="form-control" id="nom" name="nom" value="${article.nom}" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" required>${article.description}</textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="prix" class="form-label">Prix (TND)</label>
                                <input type="number" step="0.01" class="form-control" id="prix" name="prix" value="${article.prix}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="image" class="form-label">URL de l'image</label>
                                <input type="url" class="form-control" id="image" name="image" value="${article.image}"
                                       onchange="document.getElementById('imagePreview').src = this.value || 'data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'100\' height=\'100\' fill=\'%23dee2e6\' viewBox=\'0 0 16 16\'><path d=\'M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z\'/><path d=\'M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z\'/></svg>'">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="article?action=details&id=${article.id}" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle"></i> Annuler
                            </a>
                            <div>
                                <button type="submit" class="btn btn-warning me-2">
                                    <i class="bi bi-check-circle"></i> Mettre à jour
                                </button>
                                <a href="article?action=delete&id=${article.id}" class="btn btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce article?')">
                                    <i class="bi bi-trash"></i> Supprimer
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Live preview for image URL changes
    document.getElementById('image').addEventListener('input', function() {
        const preview = document.getElementById('imagePreview');
        if (this.value) {
            preview.src = this.value;
            preview.classList.remove('text-muted');
            preview.innerHTML = '';
            preview.style.background = 'transparent';
        } else {
            preview.innerHTML = '<i class="bi bi-image" style="font-size: 3rem;"></i>';
            preview.classList.add('text-muted');
            preview.style.background = '#f8f9fa';
        }
    });
</script>
</body>
</html>