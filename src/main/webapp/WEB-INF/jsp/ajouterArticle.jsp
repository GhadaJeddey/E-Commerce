<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .form-container {
            max-width: 700px;
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        .form-header {
            border-radius: 15px 15px 0 0 !important;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card form-container">
                <div class="card-header bg-primary text-white form-header">
                    <h2 class="mb-0"><i class="bi bi-plus-circle"></i> Nouveau article</h2>
                </div>
                <div class="card-body">
                    <form action="article" method="post">
                        <input type="hidden" name="action" value="add">

                        <div class="mb-3">
                            <label for="nom" class="form-label">Nom du article</label>
                            <input type="text" class="form-control form-control-lg" id="nom" name="nom" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="prix" class="form-label">Prix (TND)</label>
                                <input type="number" step="0.01" class="form-control" id="prix" name="prix" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="image" class="form-label">URL de l'image</label>
                                <input type="url" class="form-control" id="image" name="image">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="article" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle"></i> Enregistrer
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