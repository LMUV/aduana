<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calendario.aspx.cs" Inherits="aduana.Calendario" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Calendario de Revisiones Aduaneras</title>

    <style>
        body {
            background: #f0f6ff;
            font-family: Arial, sans-serif;
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



      

 
 
 

   
 .label {
     color: #0b3d91;
     font-size: 18px;
     font-weight: bold;
     display: block;
     margin-top: 5px;
 }
       .calendarContainer {
    width: 80%;
    margin: 120px auto 35px auto; /* ← margen superior ampliado */
    padding: 20px;
    background: white;
    border-radius: 14px;
    box-shadow: 0px 0px 15px rgba(0,0,0,0.1);
}


        .calendar-title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 25px;
            color: #003d73;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* ----- Estilos del calendario ----- */
        .aspNetCalendar {
            width: 100% !important;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .aspNetCalendar td {
            height: 120px !important;
            vertical-align: top;
            padding: 6px;
            border: 1px solid #c4d7f2 !important;
            background: #eaf2ff;
        }

        /* Cabeceras de los días */
        .dayHeader {
            background: #0a3d62 !important;
            color: white !important;
            font-weight: bold;
            text-transform: uppercase;
            height: 50px !important;
            font-size: 16px;
        }

        /* Eventos */
        .event-day {
            background-color: #d0e7ff;
            border-radius: 8px;
            padding: 5px;
            margin-top: 5px;
            font-size: 14px;
            color: #07457a;
            display: block;
            border: 1px solid #78a6d6;
            font-weight: bold;
        }

        /* Día actual */
        .todayCell {
            background: #b9d7ff !important;
            border: 2px solid #0057ff !important;
        }

        /* NAV (Mes anterior / siguiente) */
        .calNav {
            background: white !important;
            color: rgb(0, 0, 0, 0,10) !important;
            font-size: 22px !important;
            font-weight: bold;
            padding: 5px !important;
        }

        .calNav a {
            color: #0a3d62 !important;
            text-decoration: none;
            font-weight: bold;
        }

        /* Título del mes (el nombre del mes) */
        .calTitle {
            background: linear-gradient(90deg, #0a3d62, #145a8f) !important;
            color: black !important;
            font-size: 28px !important;   /* ← más grande */
            font-weight: bold !important;
            padding: 15px !important;
            text-align: center !important;
            text-transform: uppercase;
            letter-spacing: 3px;
            border-radius: 10px 10px 0 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="calendarContainer">
            <div class="calendar-title">Calendario de Revisiones Aduaneras</div>

            <asp:Calendar ID="calRevisiones" runat="server"
                CssClass="aspNetCalendar"
                OnDayRender="calRevisiones_DayRender"
                NextPrevFormat="FullMonth"
                ShowGridLines="true"
                DayHeaderStyle-CssClass="dayHeader"
                TitleStyle-CssClass="calTitle"
                NextPrevStyle-CssClass="calNav"
                Font-Size="Medium">
            </asp:Calendar>
        </div>
        <div class="topbar">
    <img src="Imagenes/menu.png" alt="Menú" class="menu-icon" id="menuBtn" />
    <a href="Inicio.aspx">
        <img src="Imagenes/casa.png" alt="Inicio" class="menu-icon"
             style="width:40px; position:absolute; top:20px; left:60px; cursor:pointer;" />
    </a>
    <h3 class="sistem">Sistema de Declaración de Mercancías</h3>

    

    

    <span style="margin-right: 20px;">Bienvenido(a)<br />
        <asp:Label ID="lblUsuario" runat="server" Text="Usuario"></asp:Label>
    </span>
</div>

<!--  Contenido -->


<!--  Sidebar -->
<div class="sidebar" id="sidebar">
    <div style="margin-top: 70px;"></div>
    <h2>Sistema Aduanero</h2>
    <span>Navegación</span>
    <a href="Inicio.aspx" >Inicio</a>
    <a href="Historial.aspx">Historial</a>
    <a href="Estado.aspx">Estado</a>
    <a href="Declaraciones.aspx">Declaraciones</a>
    
    <asp:LinkButton ID="btnSalir" runat="server" CssClass="logout" OnClick="btnSalir_Click">Salir</asp:LinkButton>
</div>

        <script>
    const menuBtn = document.getElementById('menuBtn');
    const sidebar = document.getElementById('sidebar');
    menuBtn.addEventListener('click', () => sidebar.classList.toggle('active'));
        </script>

    </form>
</body>
</html>
