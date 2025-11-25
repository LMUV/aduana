<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarMercancia.aspx.cs" Inherits="aduana.AgregarMercancia" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <title>Añadir Mercancías</title>
    <style>
        body { margin:0; font-family:Arial, sans-serif; background:#fff; color:#003366; }
        header { background-color:#003399; padding:20px; color:white; display:flex; justify-content:space-between; align-items:center; }
        nav a { margin:0 10px; text-decoration:none; color:white; font-weight:bold; }
        .container { padding:30px; max-width:1000px; margin:20px auto; }
        .card { background:#e6f0ff; padding:20px; border-radius:10px; margin-bottom:20px; }
        label { display:block; margin-top:10px; font-weight:bold; }
        input, select, textarea { width:100%; padding:8px; margin-top:6px; border-radius:6px; border:1px solid #ccc; }
        .actions { margin-top:15px; }
        .btn { background:#0055cc; color:white; padding:10px 16px; border:none; border-radius:6px; cursor:pointer; }
        .grid { margin-top:15px; }
    </style>
</head>
<body>
      <form id="form1" runat="server">
    <header>
        <h1>Rápido Ochoa Airlines - Aduanas</h1>
        <nav>
            <a href="sistema.aspx">Inicio</a>
            <a href="Declaraciones.aspx">Nueva Declaración</a>
            <a href="Login.aspx">Ingreso Aduanas</a>
        </nav>
    </header>

    <div class="container">
        <div class="card">
            <h2>Añadir mercancía a la declaración <asp:Label ID="lblId" runat="server" /></h2>
            <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>

            <label>Descripción</label>
            <asp:TextBox ID="txtDescripcion" runat="server" />

            <label>Tipo</label>
            <asp:TextBox ID="txtTipo" runat="server" />

            <label>Valor declarado</label>
            <asp:TextBox ID="txtValor" runat="server" />

            <label>Resultado inspección</label>
            <asp:DropDownList ID="ddlResultado" runat="server">
                <asp:ListItem>Normal</asp:ListItem>
                <asp:ListItem>Sospechosa</asp:ListItem>
              
            </asp:DropDownList>

            <div class="actions">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btn" Text="Agregar mercancía" OnClick="btnGuardarMercancia_Click" />
                &nbsp;
                <asp:Button ID="btnFinalizar" runat="server" CssClass="btn" Text="Finalizar" OnClick="btnFinalizar_Click" />
            </div>
        </div>

       
    </div>
          </form>
</body>
</html>