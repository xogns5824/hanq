<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
String filename1 ="";
String up_img= "";
String up_title = "";
int up_rprice = 0, up_pcidx = 1;
String uploadPath = request.getRealPath("./image");
int fileSize = 10 * 1024 * 1024 ;
MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
String[] arrIdx = {"loaf0001","suit0001","walk0001","runn0001","snea0001","sand0001"};
String color= "";
String wtype="",strIdx = "", idx= "",p_best = "";
int p_rprice = 0, p_point = 0, p_isview = 0;
String p_id = "",p_title="", p_img ="", p_contact ="",newPid = "",tmpNum = "" , len = "";
int pc_idx = 0, p_price = 0,p_delivery = 0, o_count = 1,newNum = 0, totalStock = 0;
String link ="", msg ="";
// String[] arrStock;	
// String[] arrSize;
ArrayList<String[]> po_stock = new ArrayList<String[]>();
// ArrayList<String[]> stock = new ArrayList<String[]>();
// ArrayList<String> size[] = new ArrayList<String>[2];
ArrayList<String> po_color = new ArrayList<String>();
ArrayList<String[]> po_size = new ArrayList<String[]>();
String[] size = {"250","255","260","265","270","275","280"};
String[] tmpStock; 
String[] chkSize;
int[] tmpSize = {0,0,0,0,0,0,0};
String[] stock;
String[] ArrayIdx = {};
wtype = multi.getParameter("wtype");
if(wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("location.replace('product_list.jsp');");
	out.println("</script>");	
}
else if(wtype.equals("up"))
{
	p_id = multi.getParameter("p_id");
	System.out.println("p_id : " + p_id);
}
else if(wtype.equals("del"))
{

	args = multi.getParameter("args");
	ArrayIdx = multi.getParameterValues("chk_sel");
	if(ArrayIdx == null || ArrayIdx.equals(""))
	{
		out.println("<script>");
		out.println("location.replace('product_list.jsp');");
		out.println("</script>");	
	}
	for(int i = 0 ; i < ArrayIdx.length ; i++)
	{
		if(i == (ArrayIdx.length-1))
		{
			where += "p_idx ="+ArrayIdx[i];	
		}
		else
		{
			where += "p_idx ="+ArrayIdx[i] +" or ";
		}
	}
	
	sql = "delete from product where "+ where;
	System.out.println(sql);
}
else if(wtype.equals("partUp"))
{
	idx = multi.getParameter("idx");
	if(idx == null || idx.equals(""))
	{
		out.println("<script>");
		out.println("location.replace('product_list.jsp');");
		out.println("</script>");
	}
	else
	{
		p_rprice = Integer.valueOf(multi.getParameter("p_rprice"+idx));
		p_point = Integer.valueOf(multi.getParameter("p_point"+idx));
		p_isview = Integer.valueOf(multi.getParameter("p_isview"+idx));
		p_best = multi.getParameter("p_best"+idx);
	}
	if(p_best == null || p_best.equals(""))
	{
		p_best = "n";
	}	
	sql = "update product set p_rprice = "+p_rprice+", p_point = "+p_point+", p_isview ="+p_isview+", p_best = '"+p_best+"' where  p_idx = "+ idx;
}
if(wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("location.replace('product_list.jsp');");
	out.println("</script>");	
}
else if(wtype.equals("up") || wtype.equals("in"))
{
	p_title = multi.getParameter("p_title");
	if(p_title == null || p_title.equals(""))
	{
		up_title =  multi.getParameter("up_title");
		if(up_title == null || up_title.equals(""))
		{
			p_title = "";
		}
		else
		{
			p_title = up_title;
		}
	}
	p_img = multi.getParameter("pImg");

	Enumeration files = multi.getFileNames();
	
	String file1 = (String)files.nextElement();
	System.out.println("file1 :"+file1);
	filename1 = multi.getFilesystemName(file1);
	System.out.println("filename1 :"+filename1);
	if(filename1 == null || filename1.equals(""))
	{
		up_img = multi.getParameter("upImg");
		if(up_img == null || up_img.equals(""))
		{
			filename1 = "none.gif";
		}
		else
		{
			filename1 = up_img;
		}
	}
	p_contact = multi.getParameter("p_contact");
	p_price = Integer.valueOf(multi.getParameter("p_price"));
	p_rprice = Integer.valueOf(multi.getParameter("p_rprice"));
	if(p_rprice == 0)
	{
		up_rprice =  Integer.valueOf(multi.getParameter("up_rprice"));
		if(up_rprice == 0)
		{
			p_rprice = 0;
		}
		else
		{
			p_rprice = up_rprice;
		}
	}
	p_point = Integer.valueOf(multi.getParameter("p_point"));
	p_delivery = Integer.valueOf(multi.getParameter("p_delivery"));
	p_best= multi.getParameter("p_best");
	pc_idx = Integer.valueOf(multi.getParameter("pc_idx"));
	if(pc_idx == 0)
	{
		up_pcidx = Integer.valueOf(multi.getParameter("up_pcidx"));
		if(up_pcidx == 0)
		{
			pc_idx = 1;
		}
		else
		{
			pc_idx = up_pcidx;
		}
	}
	p_isview = Integer.valueOf(multi.getParameter("p_isview"));
	o_count = Integer.valueOf(multi.getParameter("o_count"));
	if(o_count == 0)
	{
		o_count = 1;
	}
	for(int i = 1 ; i <= o_count ; i++)
	{
		tmpStock = multi.getParameterValues("po_stock"+i);
		color = multi.getParameter("po_color"+i);
		if(color == null || color.equals(""))
		{
			po_color.add("black");
		}
		else
		{
			po_color.add(color);
		}
		chkSize = multi.getParameterValues("po_size"+i);
		if(chkSize == null)
		{
			po_size.add(i-1, new String[]{"250"});
		}
		else
		{
			po_size.add(i-1, multi.getParameterValues("po_size"+i));
		}
		
		stock = new String[po_size.get(i-1).length];
		for(int j = 0 ; j < po_size.get(i-1).length ; j++)
		{
			for(int k = 0 ; k < 7 ; k++)
			{
				if(po_size.get(i-1)[j].equals(size[k]))
				{
					if(tmpStock[k] == null || tmpStock[k].equals(""))
					{
						tmpStock[k] = "30";
					}
					stock[j] = tmpStock[k];
				}
			}
		}
		po_stock.add(i-1, stock);
		for(int j = 0 ; j < po_size.get(i-1).length ; j++)
		{
			totalStock += Integer.valueOf(po_stock.get(i-1)[j]);
			
		}
	}
	System.out.println("p_img : " +p_img);
	System.out.println("p_title : " +p_title);
	System.out.println("p_contact : " +p_contact);
	System.out.println("p_price : " +p_price);
	System.out.println("p_rprice : " +p_rprice);
	System.out.println("p_point : " +p_point);
	System.out.println("p_delivery : " +p_delivery);
	System.out.println("p_best : " +p_best);
	System.out.println("pc_idx : " +pc_idx);
	System.out.println("p_isview : " +p_isview);
}
try
{				
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	if(wtype.equals("in"))
	{
	// 카테고리 + 넘버를 해줄 select 쿼리
	
		newPid = arrIdx[pc_idx-1];

		System.out.println("newPid : "+ newPid);
		sql = "select max(p_id) as p_id, pc_title from product as p,product_category as pc where p.pc_idx = pc.pc_idx and pc.pc_idx = "+ pc_idx;
		rs = stmt.executeQuery(sql);
		if(rs.next())
		{

			if(rs.getString("p_id") != null)
			{
				newNum = Integer.valueOf(rs.getString("p_id").substring(4,8));
				newNum++;
				len = newNum+"";
				for(int i = 0 ; i < 4 - len.length() ; i++)
				{
					tmpNum += "0";
					if(i == (3-len.length()))
					{
						tmpNum += newNum;
					}
				}
				newPid = rs.getString("pc_title").substring(0,4) + tmpNum;
			}
			else
			{
				newPid = arrIdx[pc_idx-1];
			}
			
		}
		
		// product테이블 insert 쿼리
		sql = "insert into product(p_id,p_img,p_title,pc_idx,p_contact,p_price,p_rprice,p_point,p_delivery,p_stock,p_isview,p_best)";
		sql += "values ('"+ newPid +"','"+ filename1 +"','"+ p_title +"',"+ pc_idx +",'"+ p_contact +"',"+ p_price +","+ p_rprice +","+ p_point +","+ p_delivery +","+ totalStock +","+ p_isview +",'"+ p_best +"')";
		result = stmt.executeUpdate(sql);

		if(result != 0)
		{
			for (int i = 0 ; i < o_count ; i ++)
			{
				for(int j = 0 ; j < po_size.get(i).length ; j++)
				{
					System.out.println(po_size.get(i).length);
					sql = "insert into product_option (p_id,po_color,po_size,po_stock) values ('"+ newPid +"','"+ po_color.get(i) +"','"+ po_size.get(i)[j] +"', "+ po_stock.get(i)[j] +")";
					result = stmt.executeUpdate(sql);
					if(result == 0)
					{
						msg = "옵션 등록에 실패하였습니다.";
						link = "product_list.jsp";
					}
				}
			}
			if(result != 0)
			{
				msg = "상품 등록에 성공하였습니다.";
				link = "product_form.jsp";
				args = "p_id="+newPid+"&wtype=up";
			}
		}
		else
		{
			msg = "상품 등록에 실패하였습니다.";
			link = "product_list.jsp";
		}
	}
	else if(wtype.equals("up"))
	{
		sql = "update product set p_img = '"+ filename1 +"', p_title = '"+ p_title +"', pc_idx = "+ pc_idx +" , p_contact = '"+ p_contact +"', p_price = "+ p_price +" , p_rprice = "+ p_rprice +" , p_point = "+ p_point +" , p_delivery = "+ p_delivery +" , p_isview = "+ p_isview +" , p_best = '"+p_best+"', p_stock = "+ totalStock +" where p_id = '"+ p_id +"'";
		result = stmt.executeUpdate(sql);
		if(result != 0)
		{
			result = stmt.executeUpdate("delete from product_option where p_id = '"+ p_id +"'");

			for (int i = 0 ; i < o_count ; i ++)
			{
				for(int j = 0 ; j < po_size.get(i).length ; j++)
				{
					System.out.println(po_size.get(i).length);
					sql = "insert into product_option (p_id,po_color,po_size,po_stock) values ('"+ p_id +"','"+ po_color.get(i) +"','"+ po_size.get(i)[j] +"', "+ po_stock.get(i)[j] +")";
					result = stmt.executeUpdate(sql);
				}
			}
			msg = "상품 수정에 성공하였습니다.";
			link = "product_form.jsp";
			args = "p_id="+p_id+"&wtype=up";
		}
		else
		{
			out.println("<script>");
			out.println("alert('상품 수정에 실패하였습니다.');");
			out.println("location.replace('product_list.jsp?"+ args +"');");
			out.println("</script>");
		}
	}
	else
	{
		result = stmt.executeUpdate(sql);
		if(result != 0)
		{
			if(wtype.equals("in"))
			{
				msg = "상품 등록에 성공하였습니다.";
				link = "product_form.jsp";
				args = "p_id="+newPid+"&wtype=up";
			}
			else if(wtype.equals("up"))
			{
				msg = "상품 수정에 성공하였습니다.";
				link = "product_form.jsp";
				args = "p_id="+p_id+"&wtype=up";
			}
			else if(wtype.equals("del"))
			{
				msg  = "해당 상품들이 DB에서 완전히 삭제 되었습니다.";
				link = "product_list.jsp";
			}
			else if(wtype.equals("partUp"))
			{
				msg = "해당 상품이 성공적으로 수정되었습니다.";
				link = "product_list.jsp";
			}
			
		}
		else
		{
			if(wtype.equals("in"))
			{
				msg = "상품 등록에 실패하였습니다.";
				link = "product_list.jsp";
			}
			else if(wtype.equals("up"))
			{
				
			}
			if(wtype.equals("del"))
			{
				msg  = "한번이라도 주문된 상품은 삭제할 수 없습니다.";
				link = "product_list.jsp";
			}
			else if(wtype.equals("partUp"))
			{
				msg  = "해당 상품의 수정을 실패 했습니다.";
				link = "product_list.jsp";
			}
			
		}
	}
	out.println("<script>");
	if(msg != null && !msg.equals(""))
	{
		out.println("alert('"+ msg +"');");
	}
	out.println("location.replace('"+ link +"?"+ args +"');");
	out.println("</script>");
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
try
{
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
}
%>