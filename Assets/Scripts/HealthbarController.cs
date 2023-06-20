using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class HealthbarController : MonoBehaviour
{
    [Range(0,1)]
    public float _Health;
    MaterialPropertyBlock props;
    MeshRenderer renderer;

    private void Start()
    {
        props = new MaterialPropertyBlock();
        renderer = gameObject.GetComponent<MeshRenderer>();
    }
    void Update()
    {
        props.SetFloat("_Health", _Health);
        renderer.SetPropertyBlock(props);
    }
}
