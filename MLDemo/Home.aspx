<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MLDemo.Home" %>

<script src="Scripts/jquery-1.10.2.min.js"></script>
<link href="Scripts/jquery-ui-1.11.1.custom/jquery-ui.min.css" rel="stylesheet" />
<script src="Scripts/jquery-ui-1.11.1.custom/jquery-ui.min.js"></script>
<script src="Scripts/jquery.jqplot.1.0.8r1250/dist/jquery.jqplot.min.js"></script>
<link href="Scripts/jquery.jqplot.1.0.8r1250/dist/jquery.jqplot.min.css" rel="stylesheet" />
<script src="Scripts/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.barRenderer.min.js"></script>
<script src="Scripts/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.pointLabels.min.js"></script>
<script src="Scripts/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script src="Scripts/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script src="Scripts/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.meterGaugeRenderer.min.js"></script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .bkrd {
            color: black;
            width: 1000px;
            margin-left: auto;
            margin-right: auto;
            height: 800px;
            border: 1px solid #C2E0FF;
            font-family: Arial;
            font-size: 8pt;
        }

        #inputsTable {
            width: 100%;
        }

        select {
            width: 100%;
        }

            select option:hover {
                cursor: pointer;
            }

        input {
            width: 100%;
            color: gray;
        }

        select {
            color: gray;
        }

        .approved {
            color: Green;
            font-size: 14pt;
        }

        .denied {
            color: Red;
            font-size: 14pt;
        }
    </style>
    <script type="text/javascript">
        var $j = jQuery.noConflict();

        $j(document).ready(function () {
            $j('#submitCallButton').button();

            $j("#inputsTableBody tr:even").css("background-color", "#C2E0FF");
            $j("#inputsTableBody tr:odd").css("background-color", "#F3F9FF");


            $j('#submitCallButton').click(function () {
                $j('#resultsDiv').css('display', 'none');
                $j('#loadingResultsDiv').css('display', 'block');
                $j.ajax({

                    type: "POST",

                    contentType: "application/json; charset=utf-8",

                    url: "Home.aspx/InvokeCall",

                    data: JSON.stringify({
                        paramList: new Array($j('#checkingAccountStatusDropDown').val(), $j('#durationInMonthsTextBox').val(),
                            $j('#creditHistoryDropDown').val(), $j('#purposeDropDown').val(), $j('#creditAmountTextBox').val(),
                            $j('#savingsAccountBondsTextBox').val(), $j('#presentEmploymentDropDown').val(),
                            $j('#installmentRateTextBox').val(), $j('#personalStatusSexDropDown').val(),
                            $j('#otherDebtorsDropDown').val(), $j('#presentResidenceSinceTextBox').val(),
                            $j('#propertyDropDown').val(), $j('#ageTextBox').val(),
                            $j('#otherInstallmentPlansDropDown').val(), $j('#housingDropDown').val(),
                            $j('#existingCreditsTextBox').val(), $j('#jobDropDown').val(),
                            $j('#numberofLiablePeopleTextBox').val(), $j('#telephoneDropDown').val(),
                            $j('#foreignWorkerDropDown').val()
                            )
                    }),

                    dataType: "json",

                    success: function (data) {

                        var items = JSON.parse(data.d);
                        $j('#outputText').removeClass();
                        $j('#loadingResultsDiv').css('display', 'none');
                        $j('#resultsDiv').css('display', 'block');
                        var creditScore = (parseFloat(items[21]) * 100).toFixed(2);
                        if (items[20] == "2") {
                            $j('#outputText').addClass("approved");
                            $j('#outputText').html("Congratulations!  You've been approved with a confidence score of: " + creditScore);
                        }
                        else {
                            $j('#outputText').addClass("denied");
                            $j('#outputText').html("Sorry dude!  You've been DENIED!!!  You're credit confidence score is a measly: " + creditScore);
                        }

                        ShowGraph(creditScore);
                    },

                    error: function (result) {
                        alert(result);
                    }
                });

            });
        });

        function ShowGraph(score) {

            
            $j(document).ready(function () {
                s1 = [score];

                plot4 = $j.jqplot('creditScoreChart', [s1], {
                    seriesDefaults: {
                        renderer: $j.jqplot.MeterGaugeRenderer,
                        rendererOptions: {
                            label: 'Your Credit Risk Assessment Score',
                            labelPosition: 'bottom',
                            labelHeightAdjust: 0,
                            intervalOuterRadius: 85,
                            ticks: [0, 25, 50, 75, 100],
                            intervals: [50, 70, 100],
                            intervalColors: ['#cc6666', '#E7E658', '#66cc66']
                        }
                    }
                });
            });

        }


    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="bkrd">

            <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>
            <div>
                <table id="inputsTable" class="ui-widget" style="border-collapse: collapse; border-spacing: 0px;">
                    <thead class="ui-widget-header">
                        <tr>
                            <td>Input Name</td>
                            <td>Input Value</td>
                        </tr>
                    </thead>
                    <tbody id="inputsTableBody" class="ui-widget-content">
                        <tr>
                            <td>Status of Existing Checking Account</td>
                            <td>
                                <select id="checkingAccountStatusDropDown">
                                    <option value="A11">0 DM</option>
                                    <option value="A12">< 200 DM</option>
                                    <option value="A13">> 200 DM</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Duration in Months</td>
                            <td>
                                <input id="durationInMonthsTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Credit history</td>
                            <td>
                                <select id="creditHistoryDropDown">
                                    <option value="A30">no credits taken/all credits paid back duly</option>
                                    <option value="A31">all credits at this bank paid back duly</option>
                                    <option value="A32">existing credits paid back duly till now</option>
                                    <option value="A33">delay in paying off in the past</option>
                                    <option value="A34">critical account/other credits existing (not at this bank)</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Loan Purpose</td>
                            <td>
                                <select id="purposeDropDown">
                                    <option value="A40">Car (New)</option>
                                    <option value="A41">Car (used)</option>
                                    <option value="A42">Furniture/Equipment</option>
                                    <option value="A43">Radio/Television</option>
                                    <option value="A44">Domestic Appliances</option>
                                    <option value="A45">Repairs</option>
                                    <option value="A46">Education</option>
                                    <option value="A47">Vacation</option>
                                    <option value="A48">Retraining</option>
                                    <option value="A49">Business</option>
                                    <option value="A410">Others</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Credit Amount (DM)</td>
                            <td>
                                <input id="creditAmountTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Savings Accounts/Bonds (DM)</td>
                            <td>
                                <input id="savingsAccountBondsTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Present Employment Since</td>
                            <td>
                                <select id="presentEmploymentDropDown">
                                    <option value="A71">unemployed</option>
                                    <option value="A72">< 1 Year</option>
                                    <option value="A73">1 <= 4 Years</option>
                                    <option value="A74">4 <= 7 Years</option>
                                    <option value="A75">> 7 Years</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Installment rate in percentage of disposable income</td>
                            <td>
                                <input id="installmentRateTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Personal Status and Sex</td>
                            <td>
                                <select id="personalStatusSexDropDown">
                                    <option value="A91">Male : divorced/separated</option>
                                    <option value="A92">Female : divorced/separated</option>
                                    <option value="A93">Male : Single</option>
                                    <option value="A94">Male : Married/Widowed</option>
                                    <option value="A95">Female : Single</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Other Debtors</td>
                            <td>
                                <select id="otherDebtorsDropDown">
                                    <option value="A101">None</option>
                                    <option value="A102">Co-Applicant</option>
                                    <option value="A103">Guarantor</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Present Residence Since</td>
                            <td>
                                <input id="presentResidenceSinceTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Property</td>
                            <td>
                                <select id="propertyDropDown">
                                    <option value="A121">Real Estate</option>
                                    <option value="A122">If not Real Estate, Building Society or Savings Agreement</option>
                                    <option value="A123">If not Building Society or Savings Account, Car or Other</option>
                                    <option value="A124">Unknown / No-Property</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Age in Years</td>
                            <td>
                                <input id="ageTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Other Install Plans</td>
                            <td>
                                <select id="otherInstallmentPlansDropDown">
                                    <option value="A141">Bank</option>
                                    <option value="A142">Stores</option>
                                    <option value="A143">None</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Housing</td>
                            <td>
                                <select id="housingDropDown">
                                    <option value="A151">Rent</option>
                                    <option value="A152">Own</option>
                                    <option value="A153">For Free</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Number of Existing Credits At Bank</td>
                            <td>
                                <input id="existingCreditsTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Job</td>
                            <td>
                                <select id="jobDropDown">
                                    <option value="A171">Unemployed/Unskilled</option>
                                    <option value="A172">Unskilled/Resident</option>
                                    <option value="A173">Skilled Employee/Official</option>
                                    <option value="A174">Management/Self-Employed/Highly Qualified Employee/Officer</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Number of people being liable to provide maintenance for</td>
                            <td>
                                <input id="numberofLiablePeopleTextBox" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Telephone</td>
                            <td>
                                <select id="telephoneDropDown">
                                    <option value="A191">None</option>
                                    <option value="A192">Yes, Registered under the customers name</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Foreign Worker</td>
                            <td>
                                <select id="foreignWorkerDropDown">
                                    <option value="A191">Yes</option>
                                    <option value="A192">No</option>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <input id="submitCallButton" value="Submit for Analysis" type="button" style="width: 50%;" />
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <br />
            <br />
            <br />
            <div id="loadingResultsDiv" style="text-align: center; display: none;">
                <img src="images/ajax-loader.gif" />
            </div>
            <div id="resultsDiv" style="text-align: center; display: none;">
                <b id="outputText"></b>
                <br />
                <div id="creditScoreChart" style="width: 80%; height: 250px; text-align: center; margin-left: auto; margin-right: auto;">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
