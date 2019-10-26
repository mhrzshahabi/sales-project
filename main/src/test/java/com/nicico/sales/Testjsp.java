package myMain;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * This program make new restfull jsp based on old jsp file
 *
 * abaspour
 *
 */
public class Testjsp {

    public static void main(String[] args) {
        try {
            String fileName = "D:\\NICICO-Workspace\\sales\\web\\src\\main\\resources\\META-INF\\resources\\WEB-INF\\views\\shipment\\shipmentMoisture.jsp";
            List<String> lines = new ArrayList<String>();
            boolean ok=false;
            try {
                File input = new File(fileName);
                Scanner sc = new Scanner(input);
                String done=" // ######@@@@###&&@@### ";
                while (sc.hasNextLine()) {
                    String s = sc.nextLine();
                    if (s.contains(done)) return ;
                    if (s.contains(".id") ){
                        if(!s.contains("record.id") && !s.contains("data.id")){
                            s = s.replaceAll("\\.i","I");
                        } else{
                            if(s.contains("l.id"))
                                s = s.replaceAll("l.id","lId");
                        }
                    }
                    if (s.contains("\"tbl") ){
                        String src=s.substring(s.indexOf("\"tbl"),s.indexOf("\"tbl")+5);
                        String des=s.substring(s.indexOf("\"tbl")+4,s.indexOf("\"tbl")+5);
                        des=des.toLowerCase();
                        s=s.replaceFirst(src,"\""+des);
                    }
                    if (s.contains("RestDataSource") ){
                        String src="RestDataSource";
                        String des="MyRestDataSource";
                        s=s.replaceFirst(src,"\""+des);
                    }
                    if (s.contains("fetchDataURL")) {  //fetchDataURL: "rest/port/list
                        lines.add(done);
                        String[] aa = s.split("/");
                        lines.add("        fetchDataURL: \"${contextPath}/api/" + aa[1] + "/spec-list\"");
                    } else if (s.contains("actionURL") && s.contains("/remove")) { //   actionURL: "rest/port/remove/"+PortId,
                        String[] aa = s.split("/");String[] bb = s.split("\\+");
                        lines.add(done + "pls correct callback ");
                        lines.add("actionURL: \"${contextPath}/api/"+aa[1]+"/\" + "+bb[1] );
                        lines.add("httpMethod: \"DELETE\",");
                    } else if (s.contains("actionURL") && s.contains("/add")) { //actionURL: "rest/port/add",
                        String[] aa = s.split("/");
                        lines.add(done + "pls correct callback ");
                        lines.add("actionURL: \"${contextPath}/api/"+aa[1]+"/\" ,");
                        lines.add("httpMethod: methodXXXX," );
                    } else if (s.contains("isc.RPCManager.sendRequest")) {
                        lines.add(done);
                        lines.add("var methodXXXX=\"PUT\";if (data.id==null) methodXXXX=\"POST\";");
                        lines.add(s);
                    } else if (s.contains(".data") && s.contains("==") && s.contains("success")){
                        lines.add(done);
                        lines.add( " // "+s);
                        lines.add("   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) ");
                    } else if (s.contains("httpMethod")) {
                        lines.add( " // "+s);
                    } else
                        lines.add(s);
                }
                if (lines.size() > 0) {
                    sc.close();
                    File output = new File(fileName + "1");
                    ok=input.renameTo(output);
                    if (!ok)
                        System.err.println("File cannot be renamed ");
                }
            } catch (FileNotFoundException e) {
                System.err.println("File not found. exceptionFile:");
            }
            if (lines.size() > 0 && ok ) {
                File output = new File(fileName );
                PrintWriter printer = new PrintWriter(output);
                printer.println("<spring:eval var=\"contextPath\" expression=\"pageContext.servletContext.contextPath\" />");
                for (String line : lines) {
                    printer.println(line);
                }
                printer.close();
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}