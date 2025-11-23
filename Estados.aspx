<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Estados.aspx.cs" Inherits="Aduana.Estados" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Ro(Aduana)</title>
    <style>
        
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7fb; 
            color: #333;
        }

      
        .topbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 80px;
            background-color: #0b3d91; 
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
            background-color: #ffcc00;
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

      
        .main-content {
            margin-top: 100px;
            padding: 20px;
        }

        .grid-container {
            width: 90%;
            margin: 0 auto;
            background-color: #eef3fb; 
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 10px;
        }

        
        .tabla-mantenimiento {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }
               #btninvform {
    background-color:#ffcc00 ;       
    color: #fff;                   
    border: none;                    
    border-radius: 10px;             
    padding: 10px 20px;             
    font-size: 14px;                 
    margin-top: 30px; 
    margin-left: 50px;            
    cursor: pointer;                
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;       
}
        .tabla-mantenimiento th {
            background-color: #0b3d91; 
            color: white;
            text-align: left;
            padding: 10px;
        }

        .tabla-mantenimiento td {
            padding: 10px;
            border-bottom: 1px solid #d9e3f0;
            font-size: 14px;
        }

        .tabla-mantenimiento tr:hover {
            background-color: #f1f5ff;
        }

       
        .btn-info {
            background-color: #0b3d91 !important;
            border: none !important;
            color: white !important;
            border-radius: 8px !important;
            padding: 6px 10px !important;
            transition: 0.3s ease;
        }

        .btn-info:hover {
            background-color: #072c6c !important;
        }

        .btn-primary {
            background-color: #f7a701;
             margin-left: 760px; 
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #072c6c;
        }
        .form-control {
    position: absolute; 
    margin-left: 680px; 

    width: 190px;
    padding: 8px;
    
    border-radius: 5px;
    border: 1px solid #ccc;
}

      
        .maintenance-summary {
            margin: 50px auto;
            width: 90%;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card {
            flex: 1;
            min-width: 200px;
            background: white;
            border-radius: 12px;
            padding: 15px 20px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .card .status {
            font-size: 13px;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            color: white;
            display: inline-block;
            margin-bottom: 5px;
        }

        .status.green { background: #00b386; }
        .status.yellow { background: #ffcc00; color: #333; }
        .status.red { background: #e63946; }

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
       
        <div class="topbar">
            <img src="Imagenes/menu.png" alt="Menú" class="menu-icon" id="menuBtn" />
            <a href="Inicio.aspx">
                <img src="Imagenes/casa.png" alt="Inicio" class="menu-icon"
                     style="width:40px; position:absolute; top:20px; left:60px; cursor:pointer;" />
            </a>
            <h3 class="sistem">Estados</h3>

            <asp:TextBox ID="txtBuscar" runat="server" placeholder="Buscar Mercancías" CssClass="form-control"></asp:TextBox>
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn-primary" OnClick="btnBuscar_Click" />

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
            <asp:Button ID="btninvform" runat="server" Text="Nueva Inspección" CssClass="btn-primary" OnClick="btnEstados_Click" />
           
            <div class="grid-container">
                <asp:GridView ID="gvEquipos" runat="server" AutoGenerateColumns="False"
                    CssClass="tabla-mantenimiento" GridLines="None" OnRowCommand="gvEstados_RowCommand">
                    <Columns>
                      
                         <asp:BoundField DataField="IdRevision" HeaderText="Código Revision" />
                        <asp:BoundField DataField="IdDeclaracion" HeaderText="Código Declaración" />
                           <asp:BoundField DataField="EstadoDeclaracion" HeaderText="Estado Declaración" />        
                        <asp:BoundField DataField="FechaRevision" HeaderText="Fecha de la Revision " />
                        <asp:BoundField DataField="strNomApellidos" HeaderText="Nombre Inspector" />
                         <asp:BoundField DataField="Resultado" HeaderText="Resultado " />

                       
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:Button ID="btnVer" runat="server" Text="Realizar Revision"
                                    CommandName="Ver" CommandArgument='<%# Eval("IdRevision") %>'
                                    CssClass="btn btn-info text-white fw-bold px-3 py-1" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!--  Sidebar -->
        <div class="sidebar" id="sidebar">
            <div style="margin-top: 70px;"></div>
            <h2>Sistema Aduanero</h2>
            <span>Navegación</span>
            <a href="Inicio.aspx">Inicio</a>
            <a href="Historial.aspx">Historial</a>
            <a href="Estados.aspx"  class="active">Estado</a>
            <a href="Declaraciones.aspx">Declaraciones</a>
            
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
