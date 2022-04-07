package address.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import address.bean.AddressDTO;

@Repository
@Transactional
public class AddressDAOMybatis implements AddressDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<AddressDTO> getAddressList(Map<String, Integer> map) {
		return sqlSession.selectList("addressSQL.getAddressList", map);
	}

	@Override
	public void registerAddress(AddressDTO addressDTO) {
		sqlSession.insert("addressSQL.registerAddress", addressDTO);
	}

	@Override
	public AddressDTO chkDefaultAddr(int userId) {
		return sqlSession.selectOne("addressSQL.chkDefaultAddr", userId);
	}

	@Override
	public void setDefaultAddrN(int userId) {
		sqlSession.update("addressSQL.setDefaultAddrN", userId);
	}

	@Override
	public void updateAddress(AddressDTO addressDTO) {
		sqlSession.update("addressSQL.updateAddress", addressDTO);
	}

	@Override
	public void deleteAddress(int addressId) {
		sqlSession.delete("addressSQL.deleteAddress", addressId);
	}

	@Override
	public void setDefaultAddrY(int addressId) {
		sqlSession.update("addressSQL.setDefaultAddrY", addressId);
	}

}
