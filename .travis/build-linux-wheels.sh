#!/bin/bash -eux



# Compile wheels
for PYBIN in /opt/python/*/bin; do
  if [ $(echo "${PYBIN}" | grep -o '[[:digit:]][[:digit:]]' | head -n 1) -ge 34 ]; then
    # pynanosvg only builds on Python 3.4 and newer
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/
  fi
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair "$whl" -w /io/wheelhouse/
done


# Install packages and test
for PYBIN in /opt/python/*/bin/; do
    if [ $(echo "${PYBIN}" | grep -o '[[:digit:]][[:digit:]]' | head -n 1) -ge 34 ]; then
        "${PYBIN}/pip" install /io/ --no-index -f /io/wheelhouse
    fi
done

# run tests
for PYBIN in /opt/python/*/bin; do
    if [ $(echo "${PYBIN}" | grep -o '[[:digit:]][[:digit:]]' | head -n 1) -ge 34 ]; then
        "${PYBIN}/pip" install -r /io/test-requirements.txt
        "${PYBIN}/python" -m pytest /io/
    fi
done