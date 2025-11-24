<<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Historial.aspx.cs" Inherits="Aduana.Historial" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Historial de Declaraciones - RO Aduanas</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fb;
            color: #333;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            height: 100vh;
            background-color: #0b3d91;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            padding-top: 30px;
        }

        .sidebar h2 {
            font-size: 18px;
            text-align: center;
            margin-bottom: 25px;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            padding: 10px 20px;
            display: block;
            transition: 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #f7a701;
            color: #000;
        }

        .logout {
            background-color: #e63946;
            margin: 20px;
            padding: 10px;
            border-radius: 6px;
            color: white;
            text-align: center;
            cursor: pointer;
            text-decoration: none;
        }

        .logout:hover {
            background-color: #ff4d4d;
        }

        /* Contenido principal */
        .content {
            margin-left: 240px;
            padding: 30px;
        }

        h1 {
            font-size: 26px;
            color: #0b3d91;
            margin-bottom: 20px;
        }

        .card {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        /* Botones */
        .btn {
            padding: 8px 15px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }

        .btn-blue {
            background-color: #0b3d91;
            color: white;
        }

        .btn-blue:hover {
            background-color: #072c6c;
        }

        /* Tabla de datos */
        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }

        .tabla {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .tabla th {
            background-color: #0b3d91;
            color: white;
            text-align: left;
            padding: 10px;
        }

        .tabla td {
            padding: 10px;
            border-bottom: 1px solid #e3e3e3;
        }

        .tabla tr:hover {
            background-color: #f0f4ff;
        }

        .badge-green { background: #2ecc71; color: white; padding: 3px 8px; border-radius: 8px; }
        .badge-yellow { background: #f1c40f; color: white; padding: 3px 8px; border-radius: 8px; }
        .badge-red { background: #e74c3c; color: white; padding: 3px 8px; border-radius: 8px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>RO Aduanas</h2>
            <a href="Inicio.aspx">Inicio</a>
            <a href="Historial.aspx" class="active">Historial</a>
            <a href="sistema.aspx">Estado</a>
            <a href="Declaraciones.aspx">Declarar</a>
            <asp:LinkButton ID="btnSalir" runat="server" CssClass="logout" OnClick="btnSalir_Click">Salir</asp:LinkButton>
        </div>

        <!-- Contenido principal -->
        <div class="content">
            <h1>Historial de declaraciones</h1>
            
            <div class="card">
                <asp:GridView ID="gvHistorial" runat="server" 
                    AutoGenerateColumns="False"
                    CssClass="tabla"
                    GridLines="None"
                    EmptyDataText="No hay declaraciones registradas."
                    Width="100%">
                    <Columns>
                        <asp:BoundField DataField="IdDeclaracion" HeaderText="Código" />
                        <asp:BoundField DataField="IdPasajero" HeaderText="Pasajero" />
                        <asp:BoundField DataField="IdVuelo" HeaderText="Vuelo" />
                        <asp:BoundField DataField="FechaDeclaracion" HeaderText="Fecha" />
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <%# 
                                    Eval("EstadoDeclaracion").ToString().Contains("Liberada") 
                                    ? "<span class='badge-green'>" + Eval("EstadoDeclaracion") + "</span>" :
                                    Eval("EstadoDeclaracion").ToString().Contains("Inca") 
                                    ? "<span class='badge-red'>" + Eval("EstadoDeclaracion") + "</span>" :
                                    "<span class='badge-yellow'>" + Eval("EstadoDeclaracion") + "</span>"
                                %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:Button ID="btnVer" runat="server" Text="Ver"
                                    CommandName="Ver"
                                    CommandArgument='<%# Eval("IdDeclaracion") %>'
                                    CssClass="btn btn-info text-white fw-bold px-3 py-1" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>


                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
