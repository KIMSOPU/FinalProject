package address.dao;

import java.util.List;
import java.util.Map;

import address.bean.AddressDTO;

public interface AddressDAO {

	public List<AddressDTO> getAddressList(Map<String, Integer> map);

	public void registerAddress(AddressDTO addressDTO);

	public AddressDTO chkDefaultAddr(int userId);

	public void setDefaultAddrN(int userId);

	public void updateAddress(AddressDTO addressDTO);

	public void deleteAddress(int addressId);

	public void setDefaultAddrY(int addressId);

}
