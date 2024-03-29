﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OscarsGame.Default" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <img id="imgPoster" src="<%= GetPosterUrl() %>" style="height: 450px; max-width: 100%" />
            </div>

            <div class="text-large col-8">
                <h2>Welcome!</h2>
                <br />

        <asp:Literal ID="LiteralProxiad" runat="server">
            <p>You have reached the Proxiad Oscars challenge game website.</p>

            <p>Every Proxiad member can participate in the game by <a href="Account/Login">login</a> with the Proxiad office 365 account.</p>
        </asp:Literal>

        <asp:Literal ID="LiteralDefault" runat="server">
            <p>You have reached the Oscars challenge game website.</p>

            <p>Everyone can participate in the game by <a href="Account/Login">login</a> with Google or Facebook.</p>
        </asp:Literal>

                <p>
                    You have the chance to show off your incredible predictive skills by guessing the Winners.<br />
                    Take a look of all the Categories and Nomination at the <a href="CommonPages/ShowCategories">Categories</a> page.<br />
                    Make your picks before the starting of the 95th Academy Awards ceremony on March 12, 2023.
                </p>

                <p>
                    Take a look of all the nominated movies at the <a href="CommonPages/ShowAllDBMovies">Movies</a> page.<br />
                    Mark all the movies that you have already watched.<br />
                    If several users have the same number of guessed Winners,<br />
                    the user who has watched more of the nominated movies will have an advantage.
                </p>
            </div>
        </div>
    </div>
</asp:Content>