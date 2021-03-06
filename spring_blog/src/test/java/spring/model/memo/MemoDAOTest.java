package spring.model.memo;

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

public class MemoDAOTest {
	private static BeanFactory beans;
	private static MemoDAO mdao;

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
		mdao = (MemoDAO)beans.getBean("mdao");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test @Ignore
	public void testTotal() {
		assertEquals(mdao.total("", ""), 25);
	}

	@Test @Ignore
	public void testUpViewcnt() {
		fail("Not yet implemented");
	}

	@Test @Ignore
	public void testDelete() {
		int memono=2;
		assertTrue(mdao.delete(memono));
	}

	@Test @Ignore
	public void testUpdate() {
		MemoDTO dto=new MemoDTO();
		dto.setMemono(224);
		dto.setTitle("111");
		dto.setContent("22");
		assertTrue(mdao.update(dto));
	}

	@Test @Ignore
	public void testCreate() {
		MemoDTO dto=new MemoDTO();
		dto.setTitle("junit4");
		dto.setContent("jUnit test");
		assertTrue(mdao.create(dto));
	}

	@Test @Ignore
	public void testRead() {
		int memono=224;
		mdao.upViewcnt(memono);
		assertNotNull(mdao.read(memono));
	}

	@Test @Ignore
	public void testList() {
		Map map=new HashMap();
		map.put("col", "");
		map.put("word", "");
		map.put("sno", 1);
		map.put("eno", 5);
		List<MemoDTO> list =mdao.list(map);
		assertEquals(list.size(), 5);
	}

}
