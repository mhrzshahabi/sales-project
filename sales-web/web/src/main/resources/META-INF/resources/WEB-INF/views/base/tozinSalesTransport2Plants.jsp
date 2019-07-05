<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

var out =
"<span style='font-size:22px;'>Ajax</span> " +
"<b>A</b>synchronous <b>J</b>avaScript <b>A</b>nd <b>X</b>ML (AJAX) is a " +
"Web development technique for creating interactive <b>web applications</b>. " +
"The intent is to make web pages feel more responsive by exchanging small " +
"amounts of data with the server behind the scenes, so that the entire Web " +
"page does not have to be reloaded each time the user makes a change. " +
"This is meant to increase the Web page's <b>interactivity</b>, <b>speed</b>, " +
"and <b>usability</b>.<br>" +
"(Source: <a href='http://www.wikipedia.org' title='Wikipedia' target='_blank'>Wikipedia</a>)";
out="<%=request.getAttribute("out").toString() %>";alert(out)
isc.VLayout.create({
width:"100%",height:"*",
membersMargin:5,
members:[

isc.LayoutSpacer.create({height:10}),

isc.HTMLFlow.create({
autoDraw:false,
ID:"htmlCanvas",
height:"800", padding:2, overflow:"auto",
canDragResize:true, showEdges:true,
contents: out
})
]
});
