<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Erreur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="alert alert-danger">
        <h4>Erreur</h4>
            <% if (request.getParameter("message") != null) { %>
        <p><%= request.getParameter("message") %></p>
            <% } %>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            Retour à l'accueil
        </