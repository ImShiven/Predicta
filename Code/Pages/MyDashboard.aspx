<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/MasterPage.master" CodeFile="MyDashboard.aspx.cs" Inherits="Pages_MyDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<style>

path {  stroke: #fff; }
path:hover {  opacity:0.9; }
rect:hover {  fill:blue; }
.axis {  font: 10px sans-serif; }
.legend tr{    border-bottom:1px solid grey; }
.legend tr:first-child{    border-top:1px solid grey; }

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.x.axis path {  display: none; }
.legend{
    margin-bottom:76px;
    display:inline-block;
    border-collapse: collapse;
    border-spacing: 0px;
}
.legend td{
    padding:4px 5px;
    vertical-align:bottom;
}
.legendFreq, .legendPerc{
    align:right;
    width:50px;
}

</style>

<div id='dashboard1' style="background: white; padding: 10px; margin-top: 1%; margin-left: 5%; min-height: 600px;width:90%;" >
</div>
<%--<script>
    introJs().start();
</script>--%>
<script>
    function dashboard1(id, fData) {
        var barColor = 'steelblue';
        function segColor(c) { return { Saturday: "#e08214", Sunday: "#807dba", WeekDays: "#41ab5d" }[c]; }

        // compute total for each Name.
        fData.forEach(function (d) {
            d.freq.Saturday = +d.freq.Saturday;
            d.freq.Sunday = +d.freq.Sunday;
            d.freq.WeekDays = +d.freq.WeekDays;
            d.total = d.freq.Sunday + d.freq.Saturday + d.freq.WeekDays;
        });

        // function to handle histogram.
        function histoGram(fD) {
            var hG = {}, hGDim = { t: 30, r: 0, b: 60, l: 0 };
            hGDim.w = 1200 - hGDim.l - hGDim.r,
        hGDim.h = 300 - hGDim.t - hGDim.b;

            //create svg for histogram.
            var hGsvg = d3.select(id).append("svg")
            .attr("width", hGDim.w + hGDim.l + hGDim.r)
            .attr("height", hGDim.h + hGDim.t + hGDim.b).append("g")
            .attr("transform", "translate(" + hGDim.l + "," + hGDim.t + ")");

            // create function for x-axis mapping.
            var x = d3.scale.ordinal().rangeRoundBands([0, hGDim.w], 0.1)
                .domain(fD.map(function (d) { return d[0]; }));

            // Add x-axis to the histogram svg.
            hGsvg.append("g").attr("class", "x axis")
                .attr("transform", "translate(0," + hGDim.h + ")")
                .call(d3.svg.axis().scale(x).orient("bottom"))
            .selectAll("text")
            .style("text-anchor", "end")
            .attr("dx", "-.8em")
            .attr("dy", "-.6em")
            .attr("transform", function (d) {
                return "rotate(-70)"
            });;

            // Create function for y-axis map.
            var y = d3.scale.linear().range([hGDim.h, 0])
                .domain([0, d3.max(fD, function (d) { return d[1]; })]);

            // Create bars for histogram to contain rectangles and freq labels.
            var bars = hGsvg.selectAll(".bar").data(fD).enter()
                .append("g").attr("class", "bar");

            //create the rectangles.
            bars.append("rect")
            .attr("x", function (d) { return x(d[0]); })
            .attr("y", function (d) { return y(d[1]); })
            .attr("width", x.rangeBand())
            .attr("height", function (d) { return hGDim.h - y(d[1]); })
            .attr('fill', barColor)
            .on("mouseover", mouseover)// mouseover is defined below.
            .on("mouseout", mouseout); // mouseout is defined below.

            //Create the frequency labels above the rectangles.
            bars.append("text").text(function (d) { return d3.format(",")(d[1]) })
            .attr("x", function (d) { return x(d[0]) - 15 + x.rangeBand() / 2; })
            .attr("y", function (d) { return y(d[1]) - 5; })
            .attr("text-anchor", "Saturdaydle");

            function mouseover(d) {  // utility function to be called on mouseover.
                // filter for selected Name.
                var st = fData.filter(function (s) { return s.Name == d[0]; })[0],
                nD = d3.keys(st.freq).map(function (s) { return { type: s, freq: st.freq[s] }; });

                // call update functions of pie-chart and legend.    
                pC.update(nD);
                leg.update(nD);
            }

            function mouseout(d) {    // utility function to be called on mouseout.
                // reset the pie-chart and legend.    
                pC.update(tF);
                leg.update(tF);
            }

            // create function to update the bars. This will be used by pie-chart.
            hG.update = function (nD, color) {
                // update the domain of the y-axis map to reflect change in frequencies.
                y.domain([0, d3.max(nD, function (d) { return d[1]; })]);

                // Attach the new data to the bars.
                var bars = hGsvg.selectAll(".bar").data(nD);

                // transition the height and color of rectangles.
                bars.select("rect").transition().duration(500)
                .attr("y", function (d) { return y(d[1]); })
                .attr("height", function (d) { return hGDim.h - y(d[1]); })
                .attr("fill", color);

                // transition the frequency labels location and change value.
                bars.select("text").transition().duration(500)
                .text(function (d) { return d3.format(",")(d[1]) })
                .attr("y", function (d) { return y(d[1]) - 5; });
            }
            return hG;
        }

        // function to handle pieChart.
        function pieChart(pD) {
            var pC = {}, pieDim = { w: 250, h: 250 };
            pieDim.r = Math.min(pieDim.w, pieDim.h) / 2;

            // create svg for pie chart.
            var piesvg = d3.select(id).append("svg")
            .attr("width", pieDim.w).attr("height", pieDim.h).append("g")
            .attr("transform", "translate(" + pieDim.w / 2 + "," + pieDim.h / 2 + ")");

            // create function to draw the arcs of the pie slices.
            var arc = d3.svg.arc().outerRadius(pieDim.r - 10).innerRadius(0);

            // create a function to compute the pie slice angles.
            var pie = d3.layout.pie().sort(null).value(function (d) { return d.freq; });

            // Draw the pie slices.
            piesvg.selectAll("path").data(pie(pD)).enter().append("path").attr("d", arc)
            .each(function (d) { this._current = d; })
            .style("fill", function (d) { return segColor(d.data.type); })
            .on("mouseover", mouseover).on("mouseout", mouseout);

            // create function to update pie-chart. This will be used by histogram.
            pC.update = function (nD) {
                piesvg.selectAll("path").data(pie(nD)).transition().duration(500)
                .attrTween("d", arcTween);
            }
            // Utility function to be called on mouseover a pie slice.
            function mouseover(d) {
                // call the update function of histogram with new data.
                hG.update(fData.map(function (v) {
                    return [v.Name, v.freq[d.data.type]];
                }), segColor(d.data.type));
            }
            //Utility function to be called on mouseout a pie slice.
            function mouseout(d) {
                // call the update function of histogram with all data.
                hG.update(fData.map(function (v) {
                    return [v.Name, v.total];
                }), barColor);
            }
            // Animating the pie-slice requiring a custom function which specifies
            // how the intermediate paths should be drawn.
            function arcTween(a) {
                var i = d3.interpolate(this._current, a);
                this._current = i(0);
                return function (t) { return arc(i(t)); };
            }
            return pC;
        }

        // function to handle legend.
        function legend(lD) {
            var leg = {};

            // create table for legend.
            var legend = d3.select(id).append("table").attr('class', 'legend');

            // create one row per segment.
            var tr = legend.append("tbody").selectAll("tr").data(lD).enter().append("tr");

            // create the first column for each segment.
            tr.append("td").append("svg").attr("width", '16').attr("height", '16').append("rect")
            .attr("width", '16').attr("height", '16')
			.attr("fill", function (d) { return segColor(d.type); });

            // create the second column for each segment.
            tr.append("td").text(function (d) { return d.type; });

            // create the third column for each segment.
            tr.append("td").attr("class", 'legendFreq')
            .text(function (d) { return d3.format(",")(d.freq); });

            // create the fourth column for each segment.
            tr.append("td").attr("class", 'legendPerc')
            .text(function (d) { return getLegend(d, lD); });

            // Utility function to be used to update the legend.
            leg.update = function (nD) {
                // update the data attached to the row elements.
                var l = legend.select("tbody").selectAll("tr").data(nD);

                // update the frequencies.
                l.select(".legendFreq").text(function (d) { return d3.format(",")(d.freq); });

                // update the percentage column.
                l.select(".legendPerc").text(function (d) { return getLegend(d, nD); });
            }

            function getLegend(d, aD) { // Utility function to compute percentage.
                return d3.format("%")(d.freq / d3.sum(aD.map(function (v) { return v.freq; })));
            }

            return leg;
        }

        // calculate total frequency by segment for all Name.
        var tF = ['Saturday', 'Sunday', 'WeekDays'].map(function (d) {
            return { type: d, freq: d3.sum(fData.map(function (t) { return t.freq[d]; })) };
        });

        // calculate total frequency by Name for all segment.
        var sF = fData.map(function (d) { return [d.Name, d.total]; });

        var hG = histoGram(sF), // create the histogram.
        pC = pieChart(tF), // create the pie-chart.
        leg = legend(tF);  // create the legend.
    }
</script>
<script type="text/javascript">

</script>
<script type="text/javascript">
    var freqData;
    $(document).ready(function () {
        freqData = JSON.parse($('#' + '<%=hdnData.ClientID%>').val());
            dashboard1('#dashboard1', freqData);
    });

    /*[
{ "Name": "SHIVEN", "freq": { "Sunday": "178", "Saturday": "119", "WeekDays": "249" } }
, { "Name": "THIRU", "freq": { "Sunday": "110", "Saturday": "12", "WeekDays": "674" } }
, { "Name": "SAURABH", "freq": { "Sunday": 132, "Saturday": 249, "WeekDays": 418 } }
, { "Name": "PARTH", "freq": { "Sunday": 132, "Saturday": 152, "WeekDays": 182 } }
, { "Name": "UPASANA", "freq": { "Sunday": 148, "Saturday": 304, "WeekDays": 948 } }
, { "Name": "SUNIL", "freq": { "Sunday": 161, "Saturday": 167, "WeekDays": 13 } }
, { "Name": "RAJAT", "freq": { "Sunday": 181, "Saturday": 247, "WeekDays": 13 } }
, { "Name": "SUMAN", "freq": { "Sunday": 148, "Saturday": 352, "WeekDays": 942 } }
, { "Name": "HEMA", "freq": { "Sunday": 197, "Saturday": 149, "WeekDays": 14 } }
, { "Name": "DIVJIV", "freq": { "Sunday": 162, "Saturday": 379, "WeekDays": 471 } }
, { "Name": "SOURAV", "freq": { "Sunday": 132, "Saturday": 149, "WeekDays": 418 } }
, { "Name": "HARMAN", "freq": { "Sunday": 132, "Saturday": 152, "WeekDays": 12 } }
, { "Name": "TEJINDER", "freq": { "Sunday": 148, "Saturday": 304, "WeekDays": 948 } }
, { "Name": "GURPREET", "freq": { "Sunday": 161, "Saturday": 167, "WeekDays": 103 } }
, { "Name": "PRASANNA", "freq": { "Sunday": 181, "Saturday": 247, "WeekDays": 13 } }
, { "Name": "JITHEN", "freq": { "Sunday": 149, "Saturday": 32, "WeekDays": 942 } }
, { "Name": "SUDHA", "freq": { "Sunday": 197, "Saturday": 189, "WeekDays": 14 } }
, { "Name": "SUGANTHI", "freq": { "Sunday": 162, "Saturday": 39, "WeekDays": 471 } }
, { "Name": "SWATHI", "freq": { "Sunday": 110, "Saturday": 112, "WeekDays": 674 } }
, { "Name": "ADITYA", "freq": { "Sunday": 132, "Saturday": 219, "WeekDays": 418 } }
, { "Name": "ANU", "freq": { "Sunday": 132, "Saturday": 112, "WeekDays": 182 } }
, { "Name": "SAHIL", "freq": { "Sunday": 141, "Saturday": 34, "WeekDays": 98 } }
, { "Name": "VISHAL", "freq": { "Sunday": 169, "Saturday": 167, "WeekDays": 103 } }
, { "Name": "SAKSHI", "freq": { "Sunday": 189, "Saturday": 247, "WeekDays": 123 } }
, { "Name": "VADIRAJ", "freq": { "Sunday": 148, "Saturday": 32, "WeekDays": 942 } }
, { "Name": "DEEPAK", "freq": { "Sunday": 197, "Saturday": 19, "WeekDays": 14 } }
, { "Name": "AAYUSH", "freq": { "Sunday": 162, "Saturday": 39, "WeekDays": 471 } }
, { "Name": "SHEENAM", "freq": { "Sunday": 132, "Saturday": 249, "WeekDays": 418 } }
, { "Name": "UTKARSH", "freq": { "Sunday": 132, "Saturday": 152, "WeekDays": 162 } }
, { "Name": "ARUN", "freq": { "Sunday": 441, "Saturday": 304, "WeekDays": 948 } }
, { "Name": "KARISHMA", "freq": { "Sunday": 119, "Saturday": 167, "WeekDays": 13 } }
, { "Name": "ADITI", "freq": { "Sunday": 119, "Saturday": 247, "WeekDays": 123 } }
, { "Name": "SHIVA", "freq": { "Sunday": 198, "Saturday": 135, "WeekDays": 942 } }
, { "Name": "TANMOY", "freq": { "Sunday": 197, "Saturday": 149, "WeekDays": 154 } }
, { "Name": "VIBIN", "freq": { "Sunday": 162, "Saturday": 179, "WeekDays": 471 } }
    ];*/
</script>
<asp:HiddenField ID="hdnData" Value="" runat="server" />
</asp:Content>