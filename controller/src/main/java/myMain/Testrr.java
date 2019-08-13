package myMain;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * This program make java file for another layer
 * <p>
 * abaspour
 */
public class Testrr {

	public static void err(Exception e) {
		Throwable t = e;
		String msg = (t.getCause() == null ? t.getMessage() : "");
		while (t.getCause() != null) {
			t = t.getCause();
			msg += " " + t.getMessage();
		}
		System.out.println(" $$$ error " + msg);
	}

	public static void main(String[] args) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
			err(e);
			return;
		}
		Connection conC = null;
		try {
//            conC = DriverManager.getConnection("jdbc:oracle:thin:BPMS/bpmssajab@172.16.90.41:1521:orclcntr");
			conC = DriverManager.getConnection("jdbc:oracle:thin:sales/sales@//172.16.180.22:1521/orcl.icico.net.ir");
		} catch (Exception e) {
			System.err.println("Connection Field ...&&&&&&&&&&& &&& &&&&&& !");
			e.printStackTrace();
			err(e);
			return;
		}
		try {
			Statement statementC = conC.createStatement();
			Statement statement = conC.createStatement();
			ResultSet foldersRS = statementC.executeQuery("SELECT id,folder,old_fn,old_word FROM tbl_clone order by id ");
			int len = foldersRS.getFetchSize();
			String[] folders = new String[len];
			String[] oldFileName = new String[len];
			String[] oldWords = new String[len]; // id= 0  and old_word= is BaseDTO
			String exceptionFile = ""; // old_word= ExceptionDTO shows ExceptionFile
			len = 0;
			while (foldersRS.next()) {
				folders[len] = foldersRS.getString("folder");
				oldFileName[len] = foldersRS.getString("old_fn");
				oldWords[len] = foldersRS.getString("old_word");
				if (oldWords[len].equals("ExceptionDTO"))
					exceptionFile = folders[len] + "/" + oldFileName[len];
				else
					len++;
			}
			String[] fields = new String[200];
			String[] exceptionFields = new String[200]; // BankNotFound(404),
			int exceptionFieldsLoop = 0;
			int fieldsSize = 0;
			ResultSet rs = statement.executeQuery("SELECT id,new_word,shod FROM tbl_clone_name where shod is null ");
			try {
				while (rs.next()) {
					for (int folderLoop = 1; folderLoop < len; folderLoop++) {
						fieldsSize = 0;
						if (oldFileName[folderLoop].contains("DTO.java") && oldWords[0].equals("BaseDTO"))
							try {
								String fn = folders[0] + "/" + rs.getString("new_word") + ".java";
								File input = new File(fn);
								Scanner sc = new Scanner(input);
								while (sc.hasNextLine()) {
									String s = sc.nextLine();
									if (s.contains("private") && !s.contains(" id;"))
										fields[fieldsSize++] = s;
								}
								String newWord = rs.getString("new_word");
								String newWord1 = newWord.substring(0, 1).toLowerCase() + newWord.substring(1);
								ResultSet tempRs = statementC.executeQuery(" select fun_ADD_PERMISSION('" + newWord1 + "') from dual  ");
								exceptionFields[exceptionFieldsLoop++] = "        " + newWord + "NotFound(404),";
							} catch (FileNotFoundException e) {
								System.err.println("File not found.  file:" + oldFileName);
							}

						try {
							String fn = folders[folderLoop] + "/" + oldFileName[folderLoop];
							File input = new File(fn);
							String nfn = oldFileName[folderLoop];
							String oldWord = oldWords[folderLoop];
							String newWord = rs.getString("new_word"); //@@@@@@@@@@@@@@@@@@@@@@@
							String oldWord1 = oldWord.substring(0, 1).toLowerCase() + oldWord.substring(1);
							String newWord1 = newWord.substring(0, 1).toLowerCase() + newWord.substring(1);
							nfn = nfn.replaceAll(oldWord, newWord);
							File output = new File(folders[folderLoop] + "/" + nfn);
							if (!output.exists()) {
								Scanner sc = new Scanner(input);
								PrintWriter printer = new PrintWriter(output);
								while (sc.hasNextLine()) {
									String s = sc.nextLine();
									Boolean is = (fieldsSize > 0 && s.contains("public class " + oldWords[folderLoop] + "DTO"));
									s = s.replaceAll(oldWord, newWord);
									s = s.replaceAll(oldWord1, newWord1);
									printer.println(s);
//                                    System.out.println(s);
									if (is)
										for (int k = 0; k < fieldsSize; k++)
											printer.println(fields[k]);
								}
								printer.close();
							}
						} catch (FileNotFoundException e) {
							System.err.println("File not found.  file:" + oldFileName[folderLoop]);
						}
					}
					String myStatement =
							" update tbl_clone_name set shod='shod' where id= ?  ";
					PreparedStatement update = conC.prepareStatement(myStatement);
					update.setString(1, (rs.getString("id")));
					update.executeUpdate();

				}
				conC.close();
				if (exceptionFieldsLoop > 0 && !exceptionFile.isEmpty()) {  // update Exception File
					List<String> lines = new ArrayList<String>();
					;
					try {
						File input = new File(exceptionFile);
						Scanner sc = new Scanner(input);
						while (sc.hasNextLine()) {
							String s = sc.nextLine();
							lines.add(s);
						}
					} catch (FileNotFoundException e) {
						System.err.println("File not found. exceptionFile:" + exceptionFile);
					}

					File output = new File(exceptionFile);
					PrintWriter printer = new PrintWriter(output);
					for (String line : lines) {
						printer.println(line);
						if (line.contains("public enum ErrorType")) {
							for (int i = 0; i < exceptionFieldsLoop; i++)
								printer.println(exceptionFields[i]);
							exceptionFieldsLoop = 0;
						}
					}
					printer.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}