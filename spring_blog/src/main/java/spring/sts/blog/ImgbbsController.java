package spring.sts.blog;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.imgbbs.ImgbbsDAO;
import spring.model.imgbbs.ImgbbsDTO;
import spring.utility.blog.Utility;

@Controller
public class ImgbbsController {
	@Autowired
	private ImgbbsDAO dao;

	@RequestMapping(value = "/imgbbs/delete", method = RequestMethod.POST)
	public String delete(HttpServletRequest request, int no, Model model, String col, String word, String nowPage,
			String oldfile, String passwd) {
		String basePath = request.getRealPath("/imgbbs/storage");

		Map map = new HashMap();
		map.put("no", no);
		map.put("passwd", passwd);
		boolean pflag = dao.passCheck(map);
		if (pflag) {
			if (dao.delete(no))
				Utility.deleteFile(basePath, oldfile);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);

			return "redirect:./list";

		} else {
			return "passwdError";
		}

	}

	@RequestMapping(value = "/imgbbs/delete", method = RequestMethod.GET)
	public String delete(int no, Model model, String col, String word, String nowPage) {
		boolean flag = dao.chechRefno(no);
		ImgbbsDTO dto = dao.read(no);

		model.addAttribute("dto", dto);
		model.addAttribute("flag", flag);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("col", col);
		model.addAttribute("word", word);

		return "/imgbbs/delete";
	}

	@RequestMapping(value = "/imgbbs/reply", method = RequestMethod.POST)
	public String reply(ImgbbsDTO dto, int no, Model model, HttpServletRequest request, String col, String word,
			String nowPage) {
		String basePath = request.getRealPath("/imgbbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);

		dao.addAnsnum(dto.getGrpno(), dto.getAnsnum());
		boolean flag = dao.createreply(dto);
		if (flag) {
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";

		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/imgbbs/reply", method = RequestMethod.GET)
	public String reply(int no, Model model) {
		model.addAttribute("dto", dao.readReply(no));

		return "/imgbbs/reply";
	}

	@RequestMapping(value = "/imgbbs/update", method = RequestMethod.POST)
	public String update(HttpServletRequest request, ImgbbsDTO dto, int no, Model model, String oldfile, String col,
			String word, String nowPage) {
		String basePath = request.getRealPath("/imgbbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);

		Map map = new HashMap();
		map.put("no", dto.getNo());
		map.put("passwd", dto.getPasswd());

		boolean pflag = dao.passCheck(map);
		if (pflag) {
			if (dao.update(dto)) {
				Utility.deleteFile(basePath, oldfile);

				model.addAttribute("nowPage", nowPage);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				return "redirect:./list";
			} else {
				return "error";
			}
		} else {
			if (filesize > 0)
				Utility.deleteFile(basePath, filename);
			return "passwdError";
		}

	}

	@RequestMapping(value = "/imgbbs/update", method = RequestMethod.GET)
	public String update(int no, Model model) {

		model.addAttribute("dto", dao.read(no));

		return "/imgbbs/update";
	}

	@RequestMapping("/imgbbs/read")
	public String read(ImgbbsDTO dto, int no, Model model, String col, String word, String nowPage) {
		dao.upViewcnt(no);

		dto = dao.read(no);
		Map map = dao.imgRead(no);

		BigDecimal[] noArr = { 
				((BigDecimal)map.get("PRE_NO2")),
				((BigDecimal)map.get("PRE_NO1")),
				((BigDecimal)map.get("NO")),
				((BigDecimal)map.get("NEX_NO1")),
				((BigDecimal)map.get("NEX_NO2"))

			};
							
		String[] files = { 
				((String)map.get("PRE_FILE2")),
				((String)map.get("PRE_FILE1")),
				((String)map.get("FILENAME")),
				((String)map.get("NEX_FILE1")),
				((String)map.get("NEX_FILE2"))
			};

		String content = dto.getContent().replaceAll("\r\n", "<br>");
		dto.setContent(content);

		model.addAttribute("dto", dto);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("col", col);
		model.addAttribute("word", word);
		model.addAttribute("files", files);
		model.addAttribute("noArr", noArr);

		return "/imgbbs/read";
	}

	@RequestMapping(value = "/imgbbs/create", method = RequestMethod.POST)
	public String create(ImgbbsDTO dto, HttpServletRequest request) {
		String basePath = request.getRealPath("/imgbbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";

		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		} else {
			filename = "default.jpg";
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);

		if (dao.create(dto)) {
			return "redirect:./list";
		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/imgbbs/create", method = RequestMethod.GET)
	public String create() {

		return "/imgbbs/create";
	}

	@RequestMapping("/imgbbs/list")
	public String list(HttpServletRequest request) {

		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if (col.equals("total")) {
			word = "";
		}
		// 페이징관련
		int nowPage = 1;
		int recordPerPage = 5;
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		int total = dao.total(col, word);
		List<ImgbbsDTO> list = dao.list(map);

		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);

		request.setAttribute("paging", paging);
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);

		return "/imgbbs/list";
	}
}
