<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Declaraciones.aspx.cs"
    Inherits="aduana.Declaraciones" %>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <title>Crear Declaración Aduanera</title>
    <style>
       
        body { margin:0; font-family:Arial, sans-serif; background:#fff; color:#003366; }
        header { background-color:#003399; padding:20px; color:white; display:flex; justify-content:space-between; align-items:center; }
        nav a { margin:0 10px; text-decoration:none; color:white; font-weight:bold; }
        .container { padding:30px; max-width:900px; margin:20px auto; }
        .card { background:#e6f0ff; padding:20px; border-radius:10px; }
        label { display:block; margin-top:10px; font-weight:bold; }
        input, select, textarea { width:100%; padding:8px; margin-top:6px; border-radius:6px; border:1px solid #ccc; }
        .actions { margin-top:15px; }
        .btn { background:#0055cc; color:white; padding:10px 16px; border:none; border-radius:6px; cursor:pointer; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
    <header>
        <h1>Rápido Ochoa Airlines - Aduanas</h1>
        <nav>
            <a href="sistema.aspx">Inicio</a>   
            <a href="Login.aspx">Ingreso Aduanas</a>
        </nav>
    </header>

    <div class="container">
        <div class="card">
            <h2>Crear nueva declaración</h2>
            <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
            <asp:Panel ID="pnlForm" runat="server">
                <label>Pasajero</label>
                <asp:DropDownList ID="ddlPasajero" runat="server" />

                <label>Vuelo</label>
                <asp:DropDownList ID="ddlVuelo" runat="server" />

                <label>Fecha y hora de declaración</label>
               <asp:TextBox ID="txtFecha" runat="server" TextMode="Date"></asp:TextBox>


                <label>Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server"> 
                    <asp:ListItem>En revisión</asp:ListItem>   
                </asp:DropDownList>

                <label>Observaciones</label>
                <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Rows="4" />

                <div class="actions">
                    <asp:Button ID="btnCrear" runat="server" CssClass="btn" Text="Crear declaración y añadir mercancías" OnClick="btnGuardar_Click"/>
                </div>
            </asp:Panel>
        </div>
    </div>
          
</form>
</body>
</html>