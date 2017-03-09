package spring.model.bbs;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class BbsDAOTest {
	private static BeanFactory beans;
	private static BbsDAO bdao;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		Resource resource = new ClassPathResource("blog.xml");
		beans = new XmlBeanFactory(resource);
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		bdao = (BbsDAO)beans.getBean("bdao");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test @Ignore
	public void testChechRefno() {
		int bbsno = 17;
		assertTrue(bdao.chechRefno(bbsno));
	}


	@Test @Ignore
	public void testCreate() {
		BbsDTO dto = new BbsDTO();
		dto.setWname("슬리프");
		dto.setTitle("졸려");
		dto.setContent("whfdktek");
		dto.setPasswd("123");
		dto.setFilename("text.txt");
		dto.setFilesize(100);
		assertTrue(bdao.create(dto));
	}

	@Test @Ignore
	public void testTotal() {
		assertEquals(bdao.total("wname", "c"),4);
	}
	
	@Test @Ignore
	public void testList() {
		Map map = new HashMap();
		map.put("col", "wname");
		map.put("word", "");
		map.put("sno", 1);
		map.put("eno", 5);
		List<BbsDTO> list = bdao.list(map);
		assertEquals(list.size(), 14);
	}

	@Test @Ignore
	public void testRead() {
		BbsDTO dto = bdao.read(18);
		assertNotNull(dto);
	}

	@Test @Ignore
	public void testUpViewcnt() {
		fail("Not yet implemented");
	}

	@Test @Ignore
	public void testPassCheck() {
		Map map = new HashMap();
		map.put("bbsno", 9);
		map.put("passwd", "33");
		assertTrue(bdao.passCheck(map));
	}

	@Test @Ignore
	public void testUpdate() {
		BbsDTO dto = new BbsDTO();
		dto.setBbsno(5);
		dto.setWname("TEST UPd");
		dto.setTitle("Junit 4");
		dto.setContent("Junit4 update");
		dto.setFilename("holly_Queen_mago.gif");
		dto.setFilesize(100);
		assertTrue(bdao.update(dto));
		
	}

	@Test @Ignore
	public void testDelete() {
		int bbsno = 9;
		assertTrue(bdao.delete(bbsno));
	}

	@Test @Ignore
	public void testReadReply() {
		BbsDTO dto = bdao.readReply(19);
		assertEquals(dto.getGrpno(), 14);
		assertEquals(dto.getIndent(), 0);
		assertEquals(dto.getAnsnum(), 0);
	}

	@Test @Ignore
	public void testReply() {
		BbsDTO dto = bdao.readReply(19);
		dto.setWname("JU");
		dto.setTitle("junit4 title");
		dto.setContent("j4c");
		dto.setPasswd("123");
		dto.setFilename("none");
		dto.setFilesize(200);
		bdao.addAnsnum(dto.getGrpno(), dto.getAnsnum());
		assertTrue(bdao.reply(dto));
	}

	@Test @Ignore
	public void testAddAnsnum() {
		fail("Not yet implemented");
	}

}
