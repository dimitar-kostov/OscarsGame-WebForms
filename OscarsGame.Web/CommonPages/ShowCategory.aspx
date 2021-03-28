﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowCategory.aspx.cs" Inherits="OscarsGame.CommonPages.ShowCategory" MasterPageFile="~/Site.Master" %>

<%@ Register TagPrefix="My" TagName="NominationControl" Src="~/NominationControl.ascx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/StatisticsStyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="/Content/MovieStyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/LargePoster.js"></script>

    <asp:UpdatePanel ID="CategoryDataUpdatePanel" runat="server">
        <ContentTemplate>
            <asp:Label ID="GreatingLabel" runat="server" CssClass="warning"></asp:Label>
            <asp:Label ID="WarningLabel" runat="server" CssClass="warning"></asp:Label>
            <asp:Label ID="WinnerLabel" runat="server" CssClass="greenBorder"></asp:Label>
            <div>

                <asp:Label ID="CategoryTtleLabel" CssClass="categoryTitle" runat="server" />
                <hr />
                <asp:Repeater 
                    ID="NominationsRepeater" runat="server"
                    ItemType="OscarsGame.Domain.Entities.Nomination"
                    OnItemCommand="NominationsRepeater_ItemCommand" 
                    OnItemDataBound="NominationsRepeater_ItemDataBound">
                    <HeaderTemplate>
                        <div>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="pattern">

                            <My:NominationControl ID="NominationControl1" runat="server" Item="<%# Item %>" />
                            <div class="under-movie">
                                <img class="winnerLogo" src="<%# CheckIfWinnerImage(Item) %>" />
                                <asp:LinkButton 
                                    ID="MarkAsBettedButton"
                                    runat="server"
                                    Text=""
                                    CommandName="MarkAsBetted"
                                    CommandArgument='<%# Item.Id %>'
                                    Enabled="<%# CheckIfTheUserIsLogged() & IsGameRunning()%>"
                                    Visible="<%#!IsGameNotStartedYet()%>">
                                          <%# ChangeTextIfUserBettedOnThisNomination(Item.Bets) %>
                                </asp:LinkButton>

                                <span class="label leftLabel" visible="<%#!IsGameNotStartedYet()%>">Bet for this nomination!</span>
                            </div>

                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                           
                    </FooterTemplate>
                </asp:Repeater>
        </ContentTemplate>
    </asp:UpdatePanel>

    <br />


    <asp:UpdatePanel ID="GridsUpdatePanel" runat="server" >
        <ContentTemplate>
            <br />
            <asp:Label runat="server">See how many votes and views each nomination has</asp:Label>
            <asp:GridView
                ID="MoviesScoresGridView"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AlternatingRowStyle-CssClass="alt"
                GridLines="None"
                runat="server"
                AllowSorting="false"
                AutoGenerateColumns="false"
                OnSorting="MoviesScoresGridView_Sorting">
                <Columns>
                    <asp:BoundField
                        DataField="Movie.Title"
                        HeaderText="Movie"
                        SortExpression="Movie" />
                    <asp:BoundField
                        DataField="Bets.Count"
                        HeaderText="Voted"
                        SortExpression="Bets" />
                    <asp:BoundField
                        DataField="Movie.UsersWatchedThisMovie.Count"
                        HeaderText="Watched"
                        SortExpression="Watched" />
                </Columns>
            </asp:GridView>

            <br />
            <asp:Label runat="server">See how others have voted for this category</asp:Label>
            <asp:GridView
                ID="UserVotesGridView"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AlternatingRowStyle-CssClass="alt"
                GridLines="None"
                runat="server"
                AutoGenerateColumns="false"
                AllowSorting="false"
                OnSorting="UserVotesGridView_Sorting">
            </asp:GridView>

            <br />
            <asp:Label runat="server">See which of these movies others have watched</asp:Label>
            <asp:GridView
                ID="UserWatchedGridView"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AlternatingRowStyle-CssClass="alt"
                GridLines="None"
                runat="server"
                AutoGenerateColumns="false"
                AllowSorting="false"
                OnSorting="UserWatchedGridView_Sorting">
            </asp:GridView>

        </ContentTemplate>
    </asp:UpdatePanel>

    <br />

    <asp:UpdateProgress ID="updateProgress" runat="server">
        <ProgressTemplate>
            <div class="loading-panel">
                <div class="loading-container">
                    <img src="<%= this.ResolveUrl("~/images/DoubleRing.gif")%>" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <style>
        .loading-panel {
            background: rgba(0, 0, 0, 0.2) none repeat scroll 0 0;
            position: relative;
            width: 100%;
        }

        .loading-container {
            background: rgba(49, 133, 156, 0.4) none repeat scroll 0 0;
            color: #fff;
            font-size: 90px;
            height: 100%;
            left: 0;
            padding-top: 15%;
            position: fixed;
            text-align: center;
            top: 0;
            width: 100%;
            z-index: 999999;
        }
    </style>
</asp:Content>
