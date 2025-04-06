<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>S'inscrire - Gestion des Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .registration-container {
            max-width: 450px;
            margin: 0 auto;
            padding: 20px;
        }
        .registration-card {
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.95);
        }
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        .card-title {
            color: #2c3e50;
            font-weight: 600;
        }
        .form-label {
            color: #4a5568;
        }
        .btn-primary {
            background-color: #4a90e2;
            border: none;
            padding: 12px;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background-color: #357abd;
        }
        .password-requirements {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="registration-container">
        <div class="card registration-card">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">
                    <i class="bi bi-person-plus me-2"></i>Créer un compte
                </h3>

                <%-- Affichage des messages d'erreur --%>
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <!-- Champ pour l'email -->
                    <div class="mb-4">
                        <label for="email" class="form-label">Adresse e-mail</label>
                        <input type="email" class="form-control form-control-lg" id="email" name="email" required>
                    </div>

                    <!-- Champ pour le nom d'utilisateur -->
                    <div class="mb-4">
                        <label for="username" class="form-label">Nom d'utilisateur</label>
                        <input type="text" class="form-control form-control-lg" id="username" name="username" required>
                    </div>

                    <!-- Champ pour le mot de passe -->
                    <div class="mb-3">
                        <label for="password" class="form-label">Mot de passe</label>
                        <input type="password" class="form-control form-control-lg" id="password" name="password" required>
                        <div class="password-requirements">
                            Minimum 8 caractères avec chiffres et lettres
                        </div>
                    </div>

                    <!-- Champ pour confirmer le mot de passe -->
                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
                        <input type="password" class="form-control form-control-lg" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <!-- Bouton de soumission -->
                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="bi bi-person-check me-2"></i>S'inscrire
                        </button>
                    </div>
                </form>

                <!-- Lien vers la page de connexion -->
                <div class="login-link">
                    <p class="text-muted mb-0">Déjà un compte ?
                        <a href="${pageContext.request.contextPath}/login.jsp" class="text-decoration-none">
                            Se connecter
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>