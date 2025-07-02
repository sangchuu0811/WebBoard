package boardServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.boardDAO;
import board.boardDTO;


@WebServlet(name = "ControllerBoard.do", urlPatterns = { "/ControllerBoard.do" }) // API Built-In Method → Mapping : name (Stirng), urlPatterns (String[] : 배열)
public class ControllerBoard extends HttpServlet {
       
	public void init() throws ServletException { // 옵션
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		mExecute(request, response);
	}	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		mExecute(request, response);
	}
	
	private void mExecute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter(); 				

		String category = request.getParameter("category");
		String ContextPath = request.getContextPath();
		String folderPath = "BoardV02";
		String realPath  = folderPath + "/jsp/";
		String sendPath = "";
		String writer, title, content;
		int hits=0, num=0;
		
		String curTime = LocalDate.now() + " " + 
				  LocalTime.now().toString().substring(0, 8);
		String regtime = curTime;
		
		String numStr = request.getParameter("num");
		num = (numStr != null && !numStr.isEmpty())? Integer.parseInt(numStr) : 0;
		
		writer = request.getParameter("writer");
		title = request.getParameter("title");
		content = request.getParameter("content");
		
		boardDAO bodDAO = boardDAO.getInstance(); // singleton
		boardDTO bodDTO = new boardDTO(writer, title, content, regtime, hits);
		bodDTO.setNum(num);
		bodDTO.setWriter(writer); 
		bodDTO.setTitle(title);   
		bodDTO.setContent(content);  
		
		if(category.equals("bodIns")) {
			int su = bodDAO.bodWrite(bodDTO);
			String result = URLEncoder.encode("게시글 추가 완료", "UTF-8");
			if(su != 0) {
				sendPath = realPath + "msgChk.jsp?msg=" + result;
			} else {
				sendPath = realPath + "msgChk.jsp?msg=" + URLEncoder.encode("게시글 추가 실패", "UTF-8");
			}
		} else if(category.equals("bodUpd")){
			int su = bodDAO.bodUpdate(bodDTO);
			String result = URLEncoder.encode("게시글 수정 성공", "UTF-8");
			if(su != 0) {
				sendPath = realPath + "msgChk.jsp?msg=" + result;
			} else {
				sendPath = realPath + "msgChk.jsp?msg=" + URLEncoder.encode("게시글 수정 실패", "UTF-8");
			}
		} else if(category.equals("bodDel")){
			int su = bodDAO.bodDelete(bodDTO);
			String result = URLEncoder.encode("게시글 삭제 완료", "UTF-8");
			if(su != 0) {
				sendPath = realPath + "msgChk.jsp?msg=" + result;
			} else {
				sendPath = realPath + "msgChk.jsp?msg=" + URLEncoder.encode("게시글 삭제 실패", "UTF-8");
			}
		} else if(category.equals("bodSel")) {
			boardDTO selL = bodDAO.bodSelect(num);
			request.setAttribute("bodSel", selL);
			sendPath =  folderPath +  "/jsp/boardViewFrame.jsp";
			request.getRequestDispatcher(sendPath).forward(request, response);
			return;
		}
		response.sendRedirect(sendPath);
		return;
	}
	
	public void destroy() {  // 옵션
	}

}
