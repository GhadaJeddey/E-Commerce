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
    body {
      background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
    }
    .login-container {
      max-width: 400px;
      margin: 0 auto;
      padding: 20px;
    }
    .login-card {
      padding: 2rem;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      background: rgba(255, 255, 255, 0.95);
    }
    .registration-link {
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
  </style>
</head>
<body>
<div class="container">
  <div class="login-container">
    <div class="card login-card">
      <div class="card-body">
        <h3 class="card-title text-center mb-4">
          <i class="bi bi-box-arrow-in-right me-2"></i>Connexion
        </h3>

        <%-- Affichage des messages d'erreur --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger" role="alert">
          <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/loginAction" method="post">
          <!-- Champ pour l'email -->
          <div class="mb-4">
            <label for="email" class="form-label">Adresse e-mail</label>
            <input type="email" class="form-control form-control-lg" id="email" name="email" required>
          </div>

          <!-- Champ pour le mot de passe -->
          <div class="mb-4">
            <label for="password" class="form-label">Mot de passe</label>
            <input type="password" class="form-control form-control-lg" id="password" name="password" required>
          </div>

          <!-- Bouton de soumission -->
          <div class="d-grid gap-2 mt-4">
            <button type="submit" class="btn btn-primary btn-lg">
              <i class="bi bi-unlock me-2"></i>Se connecter
            </button>
          </div>
        </form>

        <!-- Lien vers la page d'inscription -->
        <div class="registration-link">
          <p class="text-muted mb-0">Pas encore de compte ?
            <a href="${pageContext.request.contextPath}/register.jsp" class="text-decoration-none">
              Créer un compte
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