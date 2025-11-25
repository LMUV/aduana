<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notificaciones.aspx.cs" Inherits="aduana.Notificaciones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Notificaciones</title>

<style>
    body {
        background: #f4f7fa;
        font-family: Arial, Helvetica, sans-serif;
    }

    .contenedor {
        width: 90%;
        margin: 40px auto;
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 0 18px rgba(0,0,0,0.15);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 26px;
        color: #1b3c6e;
    }

    /* Estilos del GridView */
    .tablaNoti {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        border-radius: 10px;
        overflow: hidden;
    }

    .tablaNoti th {
        background: #1b3c6e;
        color: white !important;
        padding: 12px;
        text-align: center;
        font-size: 16px;
        border: none;
    }

    .tablaNoti td {
        padding: 10px;
        background: #ffffff;
        border-bottom: 1px solid #e5e5e5;
        font-size: 14px;
    }

    .tablaNoti tr:nth-child(even) td {
        background: #f0f4ff;
    }

    .tablaNoti tr:hover td {
        background: #dce7ff;
        cursor: pointer;
    }

    .tablaNoti .mensaje-largo {
        max-width: 400px;
        white-space: normal;
    }

</style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="contenedor">
            <h2>Notificaciones del Sistema</h2>

            <asp:GridView ID="gvNotificaciones" runat="server" 
                AutoGenerateColumns="False"
                CssClass="tablaNoti"
                AllowPaging="true"
                PageSize="10"
                OnPageIndexChanging="gvNotificaciones_PageIndexChanging">

                <Columns>

                    <asp:BoundField DataField="IdNotificacion" HeaderText="ID" />

                    <asp:BoundField DataField="IdPasajero" HeaderText="Pasajero" />

                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" />

                    <asp:BoundField DataField="Mensaje" HeaderText="Mensaje" 
                        ItemStyle-CssClass="mensaje-largo" />

                    <asp:BoundField DataField="FechaEnvio" HeaderText="Fecha Envío" 
                        DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                </Columns>
            </asp:GridView>

        </div>

    </form>
</body>
</html>
