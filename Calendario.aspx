<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calendario.aspx.cs" Inherits="aduana.Calendario" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    

    <!-- FullCalendar -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <title>Calendario de Revisiones Aduaneras</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7fb;
            overflow: hidden; /* Evita scroll innecesario */
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



      

 /

 
 

        /* ------------------ TOPBAR ------------------ */
        .topbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 80px;
            background-color: #0b3d91; /* Azul rey */
            display: flex;
            align-items: center;
            padding: 0 20px;
            color: white;
            font-size: 22px;
   
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
            justify-content: space-between;
            z-index: 1100;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            margin-bottom: 25px;
            color: #003d73;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .menu-icon {
            width: 45px;
            cursor: pointer;
            filter: brightness(0) invert(1);
        /* ----- Estilos del calendario ----- */
        .aspNetCalendar {
            width: 100% !important;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .sistem {
            position: absolute;
            left: 120px;
            font-size: 20px;
            font-weight: 600;
        }

        /* ------------------ SIDEBAR ------------------ */
        .sidebar {
            position: fixed;
            top: 0;
            left: -180px;
            width: 180px;
            height: 100%;
            background-color: #e6ecf8;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 15px;
            transition: left 0.3s ease;
            z-index: 1200;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
        .aspNetCalendar td {
            height: 120px !important;
            vertical-align: top;
            padding: 6px;
            border: 1px solid #c4d7f2 !important;
            background: #eaf2ff;
        }

        .sidebar.active { left: 0; }

        .sidebar h2 {
        /* Cabeceras de los días */
        .dayHeader {
            background: #0a3d62 !important;
            color: white !important;
            font-weight: bold;
            text-transform: uppercase;
            height: 50px !important;
            font-size: 16px;
            color: #0b3d91;
            margin-top: 90px;
            margin-bottom: 5px;
        }

        .sidebar span {
            font-size: 13px;
            color: #003366;
        }

        .sidebar a {
            text-decoration: none;
            color: #003366;
            padding: 8px 12px;
            width: 90%;
        /* Eventos */
        .event-day {
            background-color: #d0e7ff;
            border-radius: 8px;
            margin: 4px 0;
            display: block;
            padding: 5px;
            margin-top: 5px;
            font-size: 14px;
            color: #07457a;
            display: block;
            border: 1px solid #78a6d6;
            font-weight: bold;
        }

        .sidebar a:hover {
            background-color: #0b3d91;
            color: white;
        }

        .sidebar .active {
            background-color: #ffcc00;
            color: #333;
        }

        .logout {
            margin-top: auto;
            margin-bottom: 40px;
            background-color: #e63946;
            color: white;
            border-radius: 8px;
            padding: 8px;
            width: 90%;
            text-align: center;
        }

        /* ------------------ CALENDARIO FULL SCREEN ------------------ */
        .panel-container {
            position: absolute;
            top: 80px; /* debajo del topbar */
            left: 0;
            width: 100%;
            height: calc(100vh - 80px); /* 100% pantalla menos topbar */
            background: white;
            padding: 0;
            margin: 0;
        }

        #calendar {
            width: 100%;
            height: 100%;
            padding: 0;
            margin: 0;
        }

        .fc {
            height: 100% !important;
        }

        .fc-view-harness {
            height: 100% !important;
        }

        .fc-scroller {
            overflow: hidden !important;
        /* Día actual */
        .todayCell {
            background: #b9d7ff !important;
            border: 2px solid #0057ff !important;
        }

        .form-control {
            position: absolute;
            right: 160px;
            top: 22px;
            width: 200px;
            padding: 6px;
            border-radius: 5px;
        /* NAV (Mes anterior / siguiente) */
        .calNav {
            background: white !important;
            color: rgb(0, 0, 0, 0,10) !important;
            font-size: 22px !important;
            font-weight: bold;
            padding: 5px !important;
        }

        .btn-primary {
            position: absolute;
            right: 70px;
            top: 22px;
            padding: 7px 15px;
            border-radius: 5px;
            background-color: #ffcc00;
            color: #333;
            border: none;
        .calNav a {
            color: #0a3d62 !important;
            text-decoration: none;
            font-weight: bold;
        }

        .btn-primary:hover {
            background-color: #e6b800;
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

            
    /* Barra de color arriba del calendario */
    .fc-toolbar.fc-header-toolbar {
        background: #0A4BAF;      /* COLOR SUPERIOR */
        color: white;
        padding: 10px;
        border-radius: 10px 10px 0 0;
    }

    .fc-toolbar-title {
        color: white !important;
        font-weight: bold;
    }

    .fc-button {
        background: #ffffff !important;
        color: #0A4BAF !important;
        border: none !important;
        font-weight: bold;
    }

    .fc-button:hover {
        background: #e6e6e6 !important;
    }

    .fc-daygrid-day-number {
        font-weight: bold;
    }

    /* Sombra del calendario */
    #calendar {
        box-shadow: 0px 0px 15px rgba(0,0,0,0.25);
        border-radius: 10px;
        overflow: hidden;
        background: white;
        padding: 10px;
    }

    </style>
</head>

<body>


   <form id="form1" runat="server">
   

        <!-- ---------------- TOPBAR ---------------- -->
        <div class="topbar">
            <img src="Imagenes/menu.png" class="menu-icon" id="menuBtn" />

            <a href="Inicio.aspx">
                <img src="Imagenes/casa.png"
                     style="width:40px; position:absolute; top:20px; left:60px; cursor:pointer;" />
            </a>

            <h3 class="sistem">Calendario</h3>

           

            <span style="margin-right: 20px;">
                Bienvenido(a)<br />
                <asp:Label ID="lblUsuario" runat="server" Text="Usuario"></asp:Label>
            </span>
        </div>

        <!-- ---------------- SIDEBAR ---------------- -->
        <div class="sidebar" id="sidebar">
            <h2>Sistema Aduanero</h2>
            <span>Navegación</span>

            <a href="Dashboard.aspx" class="active">Inicio</a>
            <a href="Inventario.aspx">Historial</a>
            <a href="Mantenimiento.aspx">Estado</a>
            <a href="Hojadevida.aspx">Declaraciones</a>

            <asp:LinkButton ID="btnSalir" runat="server" CssClass="logout">Salir</asp:LinkButton>
        </div>

        <!-- ---------------- CALENDARIO FULL SCREEN ---------------- -->
        <div class="panel-container">
             <asp:ScriptManager ID="sm1" runat="server" 
                EnablePageMethods="true"
                LoadScriptsBeforeUI="true" />
            <div id="calendar"></div>
    <form id="form2" runat="server">

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

    </form>



<script type="text/javascript">

    // ------------------- SIDEBAR -------------------
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
 
    if (menuBtn) {
        menuBtn.addEventListener('click', () => {
            sidebar.classList.toggle('active');
        });
    }

    // ------------------- FULLCALENDAR -------------------
    Sys.Application.add_load(function () {   // <-- Corre DESPUÉS de que ASP.NET AJAX cargue

        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'es',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },

            events: function (fetchInfo, successCallback, failureCallback) {

                fetch('Calendario.aspx/GetMantenimientos', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json; charset=utf-8' },
                    body: "{}"
                })
                    .then(response => response.json())
                    .then(data => {
                        successCallback(data.d);  // <-- data.d contiene la respuesta del WebMethod
                    })
                    .catch(error => {
                        console.error("Error cargando eventos:", error);
                        failureCallback(error);
                    });

            }
        });

        calendar.render();
    });

</script>


    </form>
</body>
</html>