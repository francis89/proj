package spring.model.bbs;

import static org.junit.Assert.assertEquals;
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

public class ReplyDAOTest {
	private static BeanFactory beans;
	private static ReplyDAO dao;

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
		dao = (ReplyDAO)beans.getBean("rdao");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test @Ignore
	public void testRcount() {
		fail("Not yet implemented");
	}

	@Test @Ignore
	public void testCreate() {
		ReplyDTO dto = new ReplyDTO();
		dto.setBbsno(19);
		dto.setContent("댓굴2");
		dto.setId("admin");
		assertTrue(dao.create(dto));
	}

	@Test @Ignore
	public void testRead() {
		ReplyDTO dto = dao.read(8);
	//	assertEquals(dto.toString(), 1);
		assertEquals(dto.getBbsno(), 18);
		assertEquals(dto.getId(), "123");
		assertEquals(dto.getContent(), "3333");
	}

	@Test @Ignore
	public void testUpdate() {
		ReplyDTO dto = new ReplyDTO();
		dto.setBbsno(18);
		dto.setId("123");
		dto.setRnum(8);
		dto.setContent("reply update Test");
		assertTrue(dao.update(dto));
		
	}

	@Test @Ignore
	public void testList() {
		Map map = new HashMap();
		map.put("bbsno", 20);
		map.put("sno", 1);
		map.put("eno", 5);
		List<ReplyDTO> list = dao.list(map);
		assertEquals(list.size(),1);
	}

	@Test @Ignore
	public void testTotal() {
		int bbsno = 18;
		int cnt = dao.total(bbsno);
		assertEquals(cnt, 4);
	}

	@Test @Ignore
	public void testDelete() {
		assertTrue(dao.delete(10));
	}

	@Test 
	public void testBdelete() throws Exception {
		int bbsno  = 20;
		assertEquals(dao.bdelete(bbsno),1);
	}

}
