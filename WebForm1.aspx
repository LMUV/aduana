<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="Aduana.Inicio" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Ro(Aduana)</title>
    <style>
        /*  General */
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7fb; /* fondo elegante claro */
            color: #333;
        }

        /*  Barra superior */
        .topbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 80px;
            background-color: #0b3d91; /* azul rey */
            display: flex;
            align-items: center;
            padding: 0 20px;
            color: white;
            font-size: 20px;
            justify-content: space-between;
            z-index: 1100;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .menu-icon {
            width: 45px;
            cursor: pointer;
            filter: brightness(0) invert(1);
        }

        .sistem {
            position: absolute;
            left: 120px;
            color: white;
            font-weight: 600;
        }

        /*  Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: -180px;
            width: 180px;
            height: 100%;
            background-color: #e6ecf8; /* azul pastel */
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 15px;
            transition: left 0.3s ease;
            z-index: 1000;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar h2 {
            font-size: 16px;
            color: #0b3d91;
            margin-bottom: 10px;
        }

        .sidebar span {
            font-size: 13px;
            color: #004c80;
            margin-bottom: 10px;
        }

        .sidebar a {
            text-decoration: none;
            color: #003366;
            padding: 6px 12px;
            width: 90%;
            border-radius: 8px;
            text-align: left;
            margin: 4px 0;
            display: block;
            font-size: 14px;
            transition: background 0.3s, color 0.3s;
        }

        .sidebar a.active {
            background-color: #ffcc00; /* amarillo activo */
            color: #333;
            font-weight: bold;
        }

        .sidebar a:hover {
            background-color: #0b3d91;
            color: white;
        }

        .sidebar .logo-bottom {
            max-width: 120px;
            border-radius: 10px;
            margin-top: 40px;
        }

        .logout {
            margin-top: auto;
            background-color: #e63946;
            color: white;
            border-radius: 8px;
            padding: 6px 10px;
            text-align: center;
            text-decoration: none;
            width: 90%;
            margin-bottom: 70px;
        }
                        
        .logout:hover {
            background-color: #ff4d4d;
        }

        /*  Contenido principal */
        .main-content {
            margin-top: 100px;
            padding: 20px;
        }

       
       
      

        /

        
        

   
        .label {
            color: #0b3d91;
            font-size: 18px;
            font-weight: bold;
            display: block;
            margin-top: 5px;
        }
    </style>
</head>

<body>
    <form id="form2" runat="server">
        <!--  Topbar -->
        <div class="topbar">
            <img src="Imagenes/menu.png" alt="Menú" class="menu-icon" id="menuBtn" />
            <a href="Inicio.aspx">
                <img src="Imagenes/casa.png" alt="Inicio" class="menu-icon"
                     style="width:40px; position:absolute; top:20px; left:60px; cursor:pointer;" />
            </a>
            <h3 class="sistem">Sistema de Declaración de Mercancías</h3>

            

            <a href="Calendario.aspx">
                <img src="Imagenes/calendario.png" alt="Inicio" class="menu-icon"
                     style="width:35px; position:absolute; top:22px; right:200px; cursor:pointer;" />
            </a>

            <span style="margin-right: 20px;">Bienvenido(a)<br />
                <asp:Label ID="lblUsuario" runat="server" Text="Usuario"></asp:Label>
            </span>
        </div>

        <!--  Contenido -->
        <div class="main-content">
           
        </div>

        <!--  Sidebar -->
        <div class="sidebar" id="sidebar">
            <div style="margin-top: 70px;"></div>
            <h2>Sistema Aduanero</h2>
            <span>Navegación</span>
            <a href="Dashboard.aspx" class="active">Inicio</a>
            <a href="Inventario.aspx">Historial</a>
            <a href="Mantenimiento.aspx">Estado</a>
            <a href="Hojadevida.aspx">Declaraciones</a>
            
            <asp:LinkButton ID="btnSalir" runat="server" CssClass="logout" OnClick="btnSalir_Click">Salir</asp:LinkButton>
        </div>

        <!--  Resumen -->
       

        <script>
            const menuBtn = document.getElementById('menuBtn');
            const sidebar = document.getElementById('sidebar');
            menuBtn.addEventListener('click', () => sidebar.classList.toggle('active'));
        </script>
    </form>
</body>
</html>
