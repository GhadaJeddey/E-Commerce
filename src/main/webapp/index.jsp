<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Accueil - Gestion des Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .main-content {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .feature-card {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .hero-image {
            max-width: 100%;
            height: auto;
        }
        .login-container {
            max-width: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
<!-- Redirection si connecté -->
<c:if test="${not empty sessionScope.user}">
    <script>
        window.location.href = "${pageContext.request.contextPath}/article";
    </script>
</c:if>

<!-- Hero Section -->
<div class="hero-section text-white">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold mb-4">
                    <i class="bi bi-shield-lock"></i>
                    Système complet de gestion d'inventaire
                </h1>

                <!-- Bouton de connexion -->
                <div class="login-container">
                    <a href="login.jsp" class="btn btn-primary btn-lg w-100 mb-3">
                        <i class="bi bi-box-arrow-in-right"></i> Connexion
                    </a>
                    <p class="text-center">Pas de compte ?
                        <a href="register.jsp" class="text-white">Inscription</a>
                    </p>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="images/accueil.png"
                     alt="Interface de gestion"
                     class="hero-image">
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

VOICI LA PAGE INDEX
je veux qu la page login ait un font de meme couleur qur celui de index

voici login.jsp
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Se connecter - Gestion des Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 0 auto;
            padding-top: 50px;
        }
        .login-card {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .registration-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <div class="card login-card">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">Se connecter</h3>

                <%-- Affichage des messages d'erreur --%>
                <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("errorMessage") %>
                </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/loginAction" method="post">
                    <!-- Champ pour le nom d'utilisateur -->
                    <div class="mb-3">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="text" class="form-control" id="email" name="email" required>
                    </div>

                    <!-- Champ pour le mot de passe -->
                    <div class="mb-3">
                        <label for="password" class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <!-- Bouton de soumission -->
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg">Se connecter</button>
                    </div>
                </form>

                <!-- Lien vers la page d'inscription -->
                <div class="registration-link mt-3">
                    <p>Pas encore de compte? <a href="${pageContext.request.contextPath}/register.jsp">S'inscrire</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>