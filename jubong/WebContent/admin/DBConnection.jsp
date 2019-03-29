
	 <%
		 try
		 {				
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "root");
			stmt = conn.createStatement();
			 
		 }
		 catch(Exception e)
		 {
			e.printStackTrace();
		 }
		 finally
		 {
			try
			{
				rs.close();
				stmt.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		 }
		 %>